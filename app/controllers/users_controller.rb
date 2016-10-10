class UsersController < ApplicationController
  def profile
    @user = User.includes(:topics,:comments).find(params[:id])
    @comments = @user.comments.page(params[:page]).per(5)
  end
end
