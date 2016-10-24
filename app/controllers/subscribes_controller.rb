class SubscribesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    current_user.subscribed_topics << @topic
    # @subscribe = Subscribe.new
    # @subscribe.users = current_user
    # @subscribe.topics = @topic
    # @subscribe.save
    @subscribe = current_user.subscribes.find_by_topic_id(@topic)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @subscribe = current_user.subscribes.find_by_topic_id(@topic)
    @subscribe.destroy
    @subscribe = nil
    respond_to do |format|
      format.js
    end
  end
end
