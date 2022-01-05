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
    @data = @books.data
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
