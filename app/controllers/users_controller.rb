class UsersController < ApplicationController

  def index
  end

  def show
    user = User.new(name: "Michael Hartl", email: "michalec1999@yahoo.com", password: "foobar", password_confirmation: "foobar")
    user.save
=begin
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
      # handle a successful save
    else
      render 'new'
    end
  end

  private 
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end