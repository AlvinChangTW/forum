class LikesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    # @like = Like.new
    # @like.topic_id = @topic.id
    # @like.user_id = current_user.id
    # @like.save
    #全部變下面的一行
    #Like.create( :topic_id => @topic.id, :user_id => current_user.id )
    #或是下面這行也行
    current_user.liked_topics << @topic
    @like = current_user.likes.find_by_topic_id(@topic)
    respond_to do |format|
      format.js
    end
    #render "topics/show"
  end
  def destroy
    @topic = Topic.find(params[:topic_id])
    @like = current_user.likes.find_by_topic_id(@topic)
    @like.destroy
    @like = nil
    #因為@like.destroy後資料庫把內容刪除後沒有把@like撈出來暫存的資料刪除
    respond_to do |format|
      format.js
    end
    #render "topics/show"
  end
  private
  # def like_params
  #   params.require(:like).permit(:topic_id, :user_id)
  # end
end
