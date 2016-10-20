class Admin::TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  layout "admin"

  def index
    if params[:order]=="comments_time"
      @topics=Topic.includes(:comments, :categories).order("comments.created_at DESC").page(params[:page]).per(10)
      #上面代表topic依照comments的created_at欄位做排序
    elsif params[:order]=="comments_count"
      @topics=Topic.includes(:comments, :categories).order("comments_count DESC").page(params[:page]).per(10)
    elsif params[:order]=="views_count"
      @topics=Topic.includes(:comments, :categories).order("view DESC").page(params[:page]).per(10)
    else
      @topics = Topic.includes(:comments).page(params[:page]).per(10)
    end
  end

  protected
  def check_admin
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
      # flash[:alert]="沒有權限"
      # redirect_to :root
    end
  end
end
