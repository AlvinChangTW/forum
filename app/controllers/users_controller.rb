class UsersController < ApplicationController
  def profile
    @user = User.includes(:topics,:comments).find(params[:id])

  end
end
