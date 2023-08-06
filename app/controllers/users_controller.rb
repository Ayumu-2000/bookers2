class UsersController < ApplicationController
  def index
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:introduction, :name, :profile_image)
  end

  def is_matching_login_user
    user_id = User.find(params[:id])
    login_user_id = current_user.id
    if(user_id.id != login_user_id)
      redirect_to user_path(current_user.id)
    end
  end
end
