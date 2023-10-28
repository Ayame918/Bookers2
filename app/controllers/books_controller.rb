class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "book successfully created."
      redirect_to books_path
    else
      flash[:error] = "Error: book creation failed."
      render :new
    end
  end

  def index
    @books = Book.all
    @user = current_user
  end 

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path(id: current_user)
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

end
