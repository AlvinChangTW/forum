class UsersController < ApplicationController
  def profile
    @user = User.includes(:topics,:comments,:likes).find_by_nickname(params[:id])
    @comments = @user.comments.page(params[:page]).per(5)
    @likes = @user.liked_topics

  end
end
