class LikesController < ApplicationController
  before_action :find_item
  before_action :find_like, only: [:destroy, :create]

  def create
    # if already_liked?
    #   destroy
    # else
      if @trip_item.likes.create(user_id: current_user.id)
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
  #   end
  #   redirect_back fallback_location: root_path
  end

  def destroy
    @like.destroy_all
    # redirect_to trip_trip_item_path(@trip_item)
  end

  private

  def find_item
    @trip_item = TripItem.find(params[:trip_item_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, trip_item_id:
    params[:trip_item_id]).exists?
  end

  def find_like
    @like = @trip_item.likes.where(user_id: current_user)
  end
end
