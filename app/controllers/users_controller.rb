class UsersController < ApplicationController
  def index
  end

  def show
  	user = User.new(name: "Michael Hartl", email: "mhartl@example.com", password: "foobar", password_confirmation: "foobar")
	user.save
    @user = User.find(params[:id])
  end

  def new
  end
end
