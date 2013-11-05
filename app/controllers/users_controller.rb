class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
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
    @user = User.new
  end

  def create
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

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    #@user = User.find(params[:id])
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

end