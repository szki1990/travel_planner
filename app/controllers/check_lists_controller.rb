class CheckListsController < ApplicationController
  before_action :set_book
  before_action :set_check_list, only: [:show, :edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:new, :index, :show, :edit, :update, :dastroy]

  def new
    @check_list = @book.check_lists.build
  end

  def create
    @check_list = @book.check_lists.build(check_list_params)
    if @check_list.save
      redirect_to book_check_lists_path(@book), notice: "リストが作成されました。"
    else
      render :new
    end
  end

  def index
    @check_lists = @book.check_lists
  end

  def show
  end

  def edit
  end

  def update
    if @check_list.update(check_list_params)
      redirect_to book_check_lists_path(@book), notice: "更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @check_list.destroy
    redirect_to book_check_lists_path(@book), notice: "リスト削除されました。"
  end

  private
    def set_check_list
      @check_list = @book.check_lists.find(params[:id])
    end

    def set_book
      @book = Book.find(params[:book_id])
    end

    def check_list_params
      params.require(:check_list).permit(:title)
    end

    def is_matching_login_user
      unless @book.user_id == current_user.id || @book.shared_users.include?(current_user)
        redirect_to book_schedules_path(@book)
      end
    end
end
