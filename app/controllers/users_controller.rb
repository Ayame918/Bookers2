class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_name = current_user.name
    @books = user.books
  end
  
  def index
    @users = User.all
     @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User successfully created."
      redirect_to @user
    else
      flash[:error] = "Error: User creation failed."
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
  
  def user_params
  params.require(:user).permit(:name, :introduction)
  end
end
