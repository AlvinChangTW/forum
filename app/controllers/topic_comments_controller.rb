class TopicCommentsController < ApplicationController
  before_action :set_topic
  before_action :set_comments
  # before_action :new ,:only=>[:create]
  # def new
  #   @comment = @topic.comments.build
  # end
  def create
    #@comment = Comment.new(comment_params)  peter
    #@comment.topic_id = @topic.id
    @comment = @topic.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice]="留言成功"
      #@topic.view-=1
      #@topic.save
      #redirect_to topic_path(@topic)
      render "topics/show"
    else
      flash[:alert]="留言失敗"
      render "topics/show"
    end
    #不知為何新增留言失敗還是會+2view,
    #原因是@comment = @topic.comments.build(comment_params)
    #因為@topic和comment有關聯，而comment有設定validates_presence_of :content
    #所以@comment的content是nil時無法寫入，連帶影響@topic.save無法執行
    #解法是留言失敗不要用redirect_to topic_path(@topic),用render "topics/show"
  end
  def edit
    @comment = Comment.find(params[:id])
  end
  def update
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.update(comment_params)
      flash[:notice]="更新留言成功"
    elsif @comment.user != current_user
      flash[:alert]="沒有權限"
    else
      flash[:alert]="更新留言失敗"
    end
    render "topics/show"
  end
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user !=current_user
      flash[:alert]="沒有權限"
    else
      @comment.destroy
    end
      redirect_to topic_path(@topic)
  end
  private
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
  def set_comments
    @comments = @topic.comments
  end
  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
