class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params.except(:admin_code))

    if params[:user][:admin_code] == "666"
      @user.admin = true
    end

    if @user.save
      redirect_to root_path, notice: "Thank you for signing up"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit_password
  end

  def edit_profile
    @user = current_user
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

  def update_profile
    @user = current_user
    if @user.authenticate(params[:user][:password])
      @user.update(user_params)
      redirect_to root_path, notice: "Profile updated successfully"
    else
      flash.now[:alert] = "Invalid password"
      render :edit_profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :bio, :admin_code)
  end
end
