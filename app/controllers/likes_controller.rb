class LikesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @like = Like.new
    @like.topic_id = @topic.id
    @like.user_id = current_user.id
    @like.save
    render "topics/show"
  end
  def destroy
    @topic = Topic.find(params[:topic_id])
    @like = current_user.likes.find_by_topic_id(@topic)
    @like.destroy
    @like = nil
    #因為@like.destroy後資料庫把內容刪除後沒有把@like撈出來暫存的資料刪除
    render "topics/show"
  end
end
