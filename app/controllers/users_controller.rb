class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "Thank you for signing up"
    else
      render :new
    end
  end

  def edit_password
  end

  def show
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.authenticate(params[:user][:password])
      @user.update(password: params[:user][:new_password])
      redirect_to root_path, notice: "Password updated successfully"
    else
      render :edit_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
