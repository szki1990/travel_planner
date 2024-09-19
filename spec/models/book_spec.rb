# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, "モデルに関するテスト", type: :model do
    describe '実際に保存してみる' do
        it "有効な投稿内容の場合は保存されるか" do
            expect(FactoryBot.build(:book)).to be_valid
        end
    end
    context "空白のバリデーションチェク" do
        it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
            book = Book.new(title: '', start_day: Date.new(2024, 9, 19), end_day: Date.new(2024, 9, 20))
            expect(book).to be_invalid
            expect(book.errors[:title]).to
        end
        it "start_dayが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
            book = Book.new(title: 'hoge', start_day: '', end_day: Date.new(2024, 9, 20))
            expect(book).to be_invalid
            expect(book.errors[:start_day]).to
        end
        it "start_dayが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
            book = Book.new(title: 'hoge', start_day: Date.new(2024, 9, 19), end_day: '')
            expect(book).to be_invalid
            expect(book.errors[:end_day]).to
        end
    end 
end 