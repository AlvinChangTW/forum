class TopicsController < ApplicationController
 def index
    @topics = Topic.all
    @topics = Topic.page(params[:page]).per(5)
  end
  def new
    @topic = Topic.new
  end
  def create
    @topic = Topic.new(topic_params)
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
  end
  def edit
    @topic = Topic.find(params[:id])
  end
  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
       flash[:notice] = "更新成功"
       redirect_to topics_path
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

  private
  def topic_params
    params.require(:topic).permit(:name, :content)
  end
end

