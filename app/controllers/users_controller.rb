class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  
  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    if @user !=current_user
      redirect_to user_path(current_user.id)
    end
  end
  
  def create
    @user = User.new(user_params)
      # プロフィール画像をアップロードする場合の処理
    if params[:user][:profile_image].present?
      # プロフィール画像を保存または更新するロジックを追加
      @user.profile_image.attach(params[:user][:profile_image])
    end
    
    if @user.save
      flash[:notice] = "You have created a user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile_image, :introduction)
  end
end
