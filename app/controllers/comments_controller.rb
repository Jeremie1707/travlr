class CommentsController < ApplicationController
  before_action :set_trip_item, only: [:create, :show]
  # def new
  #   @comment = Comment.new
  # end

  def create
    @trip = Trip.find(params[:trip_id])
    @comment = Comment.new(strong_params)
    @comment.user = current_user
    @comment.trip_item = @trip_item
    raise
    if @comment.save
      respond_to do |format|
        format.html { redirect_to trip_item_path(@trip, @trip_item) }
        format.js # <-- will render `app/views/comments/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'trip_items/show' }
        format.js
      end
    end
  end

  def show
  end

  private

  def strong_params
    params.require(:comment).permit(:comment)
  end

  def set_trip_item
    @trip_item = TripItem.find(params[:trip_item_id])
  end

end
