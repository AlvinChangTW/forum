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
  def new
    @topic = Topic.new
  end
  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    #if @topic.save
      flash[:notice]="新增成功"
      redirect_to topics_path
    # else
    #   flash[:alert]="新增失敗"
    #   render :action => :new
    # end
  end
  def show
    @topic = Topic.find(params[:id])
    @topic.view += 1
    @topic.save
    @comments = @topic.comments
    @comments_number = @comments.count
    @like = current_user.likes.find_by_topic_id(@topic)
    # if params[:like]=="true"


    # elsif params[:like]=="cancel"
    #   @like = Like.where(:topic_id => @topic).first
    #   @like.destroy
    #   render :show
    #   # Like.liked_user = current_user.id
    #   # @like = find_by_liked_user(current_user.id)
    #   # @like.liked_topic = @topic.id
    # end

    if params[:order]=="created_at"
      @comments = @comments.order("created_at DESC")
    # elsif params[:order]=="@comments_number"
    #   @comments = @comments.order("@comments_number DESC")
    end


  end
  def edit
    @topic = Topic.find(params[:id])
    # if @topic.user !=current_user
    #   flash[:alert]="沒有權限"
    #   redirect_to topics_path
    # end
  end
  def update
    @topic = Topic.find(params[:id])
    # if @topic.user == current_user
    if @topic.update(topic_params)
       flash[:notice] = "更新成功"
       redirect_to topics_path
    # elsif @topic.user != current_user
       # flash[:alert]="沒有權限"
       # render :action => :edit
    else
       flash[:alert]="更新失敗"
       render :action => :edit
    end
  end
  def destroy
    @topic = Topic.find(params[:id])
    # if @topic.user !=current_user
      # flash[:alert]="沒有權限"
    # else
      @topic.destroy
    # end
      redirect_to topics_path
  end
  def about
    @topics_number=Topic.all.count
    @comments_number=Comment.all.count
    @users_number=User.all.count
  end
  private
  def topic_params
    params.require(:topic).permit(:name, :content, :user_id, :view, :category_ids =>[])
  end
  # def like_params
  #   params.require(:like).permit(:user_id,:topic_id)
  # end

  protected
  def check_admin
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
      # flash[:alert]="沒有權限"
      # redirect_to :root
    end
  end
end
