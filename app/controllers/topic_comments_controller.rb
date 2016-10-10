class TopicCommentsController < ApplicationController
  before_action :set_topic
  # before_action :new ,:only=>[:create]
  # def new
  #   @comment = @topic.comments.build
  # end
  def create
    @comment = @topic.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
       flash[:notice]="留言成功"
       redirect_to topic_path(@topic)
    else
       flash[:alert]="留言失敗"
       redirect_to topic_path(@topic)
    end
  end

  private
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
