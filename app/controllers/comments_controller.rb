class CommentsController < ApplicationController
  def create
    @trip_item = TripItem.find(params[:trip_item_id])
    @comment = Comment.new(comment_params)
    @comment.trip_item = @trip_item
    if @comment.save
      respond_to do |format|
        format.html { redirect_to trip_item_path(@trip_item) }
        format.js  # <-- will render `app/views/comments/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'trip_items/show' }
        format.js
      end
    end
  end

  private

  def review_params
    params.require(:comment).permit(:comment)
  end
end
