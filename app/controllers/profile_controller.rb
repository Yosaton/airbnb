class ProfileController < ApplicationController
  def Show
    # @listing = Listing.find(params[:id])
    @listings = Listing.all.order(:title).page params[:page]
    @user = current_user
    @reservations = Reservation.all
    @reservation = current_user.reservations
    # @reservation.user_id = current_user.id
  end
end
