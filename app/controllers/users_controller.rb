class UsersController < ApplicationController
  
  # Load @user before selected actions to avoid repeating code (DRY).
  # Runs set_user only for show, edit, update, and destroy actions.
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users=User.all
  end

  def show
    #@user=set_user
    if @user.nil?
      flash[:info]='User not found!'
      redirect_to users_path
    end
  end

  def new
    #debugger
    @user=User.new
    Rails.logger.debug "*****************************************"
    Rails.logger.debug @user.attributes.inspect
    Rails.logger.debug "*****************************************"


  end

  def create
   @user=User.new(user_params)
   if @user.save
    redirect_to user_path(@user.id), notice: 'User was successfully created.' 
   else
     #  returning the appropriate HTTP status code (422) when validation fails.
     render 'new', status: :unprocessable_entity
   end
  end

  def edit
     #@user=set_user
  end
  
  def update
    #@user=set_user
    if @user.update(user_params)
      redirect_to users_path, notice:'User was successfully updated'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    #@user = set_user  # Find the user by ID
    @user.destroy     # Delete the user
    # Redirect to the users list with a success message
    redirect_to users_path, alert: 'User was successfully deleted.' 
  end

  private 

   def set_user
    @user=User.find_by_id(params[:id])
  end
  
    # Params is an ActionController method that returns a hash-like object.
    # Security practice known as strong parameters in the controller layer. 
    # This allows us to specify which parameters are permitted.(best practice)
   def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end

end
