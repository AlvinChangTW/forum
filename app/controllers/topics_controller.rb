class TopicsController < ApplicationController
 def index
    if params[:order]=="comments_time"
      @topics=Topic.includes(:comments, :categories).order("comments.created_at DESC").page(params[:page]).per(10)
      #上面代表topic依照comments的created_at欄位做排序
    elsif params[:order]=="comments_count"
     @topics=Topic.includes(:comments, :categories).order("comments_count DESC").page(params[:page]).per(10)
    else
      @topics = Topic.all.page(params[:page]).per(10)
    end


    # @topics = @topics.page(params[:page]).per(5)
  end
  def new
    @topic = Topic.new
  end
  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      flash[:notice]="新增成功"
      redirect_to topics_path
    else
      flash[:alert]="新增失敗"
      render :action => :new
    end
  end
  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments
    @comments_number = @comments.count
    if params[:order]=="created_at"
      @comments = @comments.order("created_at DESC")
    # elsif params[:order]=="@comments_number"
    #   @comments = @comments.order("@comments_number DESC")
    end


  end
  def edit
    @topic = Topic.find(params[:id])
  end
  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params) && @topic.user == current_user
       flash[:notice] = "更新成功"
       redirect_to topics_path
    elsif @topic.user != current_user
       flash[:alert]="沒有權限"
       render :action => :edit
    else
       flash[:alert]="更新失敗"
       render :action => :edit
    end
  end
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path
  end
  def about
    @topics_number=Topic.all.count
    @comments_number=Comment.all.count
    @users_number=User.all.count
  end
  private
  def topic_params
    params.require(:topic).permit(:name, :content, :category_ids =>[])
  end
end

