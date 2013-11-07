class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
=begin    
    user = User.new(name: "Michael Hartl", email: "michalec1999@yahoo.com", password: "foobar", password_confirmation: "foobar")
    user.save
  	user = User.first
    user.update_attributes(name: "Michael Hartl Example User",
                       email: "example@railstutorial.org",
                       password: "foobar",
                        password_confirmation: "foobar")
=end
    @user = User.find(params[:id])
  end

  def new
    if signed_in?
      redirect_to(root_url)
    else
      @user = User.new
    end
  end

  def create
    if signed_in?
      redirect_to(root_url)
    else
      @user = User.new(user_params)
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        # handle a successful save
        redirect_to @user
      else
        render 'new'
      end
    end
  end

  def update
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy
    @user = User.find(params[:id])

    if current_user == @user && current_user.admin?
      flash[:error] = "Can not delete own admin account!"
    else
      @user.destroy
      flash[:success] = "User deleted"
    end

    redirect_to users_url
  end

  private 
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end