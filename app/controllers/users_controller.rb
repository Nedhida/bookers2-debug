class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book = @books.today
    @yesterday_book = @books.yesterday
    @two_day_book = @books.two_day_ago
    @three_day_book = @books.three_day_ago
    @four_day_book = @books.four_day_ago
    @five_day_book = @books.five_day_ago
    @six_day_book = @books.six_day_ago
    @data = [['６日前', @books.six_day_ago.count],['５日前', @books.five_day_ago.count],['４日前', @books.four_day_ago.count], ['３日前', @books.three_day_ago.count], ['２日前', @books.two_day_ago.count], ['1日前', @books.yesterday.count], ['今日', @books.today.count]]
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def following
    @users = User.find(params[:id])
    @user = @users.following
    render 'relationships/following'
  end

  def followers
    @users = User.find(params[:id])
    @user = @users.followers
    render 'relationships/followers'
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
