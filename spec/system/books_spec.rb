# frozen_string_literal: true

require "rails_helper"

describe "投稿のテスト" do
  let!(:user) { create(:user, name: "hoge", email: "hoge@example.com", password: "password") }
  let!(:book1) { create(:book, title: "しおり1", start_day: "2024/09/20", end_day: "2024/09/20", public_status: true, user: user) }
  let!(:book2) { create(:book, title: "しおり2", start_day: "2024/09/22", end_day: "2024/09/23", public_status: false, user: user) }

  describe "トップ画面(homes_top_path)のテスト" do
    before do
      visit root_path
    end
    context "表示の確認" do
      it "トップ画面(root_path)に「Travel Planner」が表示されているか" do
        expect(page).to have_content "Travel Planner"
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq("/")
      end
    end
  end

  describe "しおり作成画面のテスト" do
      before do
        sign_in user
        visit new_book_path
      end
      context "表示の確認" do
        it 'new_book_pathが"/books/new"であるか' do
          expect(current_path).to eq("/books/new")
        end
        it "作成ボタンが表示されているか" do
          expect(page).to have_button "作成する"
        end
      end

      context "作成処理のテスト" do
        it "作成後のリダイレクト先は正しいか" do
          fill_in "book[title]", with: Faker::Lorem.characters(number: 5)
          fill_in "book[start_day]", with: "2024/09/20"
          fill_in "book[end_day]", with: "2024/09/20"
          select "公開", from: "book[public_status]"
          click_button "作成する"
          expect(page).to have_current_path books_path
          expect(page).to have_content "しおりを作成しました"
        end
      end
    end

  describe "しおり画面のテスト" do
    before do
      sign_in user
    end
    context "しおり一覧の表示確認" do
      before do
        visit books_path
      end
      it 'books_pathが"/books"であるか' do
        expect(current_path).to eq("/books")
      end
      it "作成されたしおりが自分のページで表示されているか" do
        expect(page).to have_content book1.title
        expect(page).to have_content book1.start_day.strftime("%Y年%m月%d日")
        expect(page).to have_content book1.end_day.strftime("%Y年%m月%d日")
        expect(page).to have_content "公開"
      end
      it "非公開のしおりも表示されているか" do
        expect(page).to have_content book2.title
        expect(page).to have_content book2.start_day.strftime("%Y年%m月%d日")
        expect(page).to have_content book2.end_day.strftime("%Y年%m月%d日")
      end
    end
    context "みんなのしおり一覧の表示確認" do
      before do
        visit public_index_books_path
      end
      it 'public_index_books_pathが"/books/public_index"であるか' do
        expect(current_path).to eq("/books/public_index")
      end
      it "作成されたものがみんなのページで表示されているか" do
        expect(page).to have_content book1.title
        expect(page).to have_content book1.end_day.strftime("%Y-%m-%d")
      end
      it "非公開のしおりは表示されないこと" do
        expect(page).not_to have_content book2.title
        expect(page).not_to have_content book2.start_day.strftime("%Y-%m-%d")
        expect(page).not_to have_content book2.end_day.strftime("%Y-%m-%d")
      end
    end
    context "詳細画面のテスト" do
      before do
        visit book_path(book1)
      end
      it "削除リンクが表示されているか" do
        expect(page).to have_link "削除"
      end
      it "編集リンクが表示されているか" do
        expect(page).to have_link "編集"
      end
    end
    context "リンクの遷移先の確認" do
      it "編集の遷移先は編集画面か" do
        visit book_path(book1)
        edit_link = find_link("編集")
        edit_link.click
        expect(current_path).to eq(edit_book_path(book1))
      end
    end
    context "しおりの編集テスト" do
      before do
        visit edit_book_path(book1)
      end
      it "表示の確認" do
        expect(page).to have_field 'book[title]', with: book1.title
        expect(page).to have_field 'book[start_day]', with: book1.start_day.strftime("%Y-%m-%d")
        expect(page).to have_field 'book[end_day]', with: book1.end_day.strftime("%Y-%m-%d")
        expect(page).to have_field 'book[public_status]', with: book1.public_status
      end
      it "保存ボタンが表示される" do
        expect(page).to have_button '更新'
      end
    end
    context "更新処理に関するテスト" do
      before do
        visit edit_book_path(book1)
      end
      it "更新後のリダイレクト先は正しいか" do
        fill_in "book[title]", with: "新しいタイトル"
        fill_in "book[start_day]", with: "2024/09/20"
        fill_in "book[end_day]", with: "2024/09/20"
        select "公開", from: "book[public_status]"
        click_button '更新'
      end
    end
    context "しおりの削除のテスト" do
      it "しおりの削除" do
        visit book_path(book1)
        expect { click_link "削除" }.to change { Book.count }.by(-1)
        expect(page).to have_content "しおりを削除しました"
      end
    end
  end
end
