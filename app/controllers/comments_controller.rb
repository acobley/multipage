class CommentsController < ApplicationController
def create
    @event = Event.find(params[:post_id])
    @comment = @event.comments.create(params[:comment])
    redirect_to event_path(@event)
  end

end
