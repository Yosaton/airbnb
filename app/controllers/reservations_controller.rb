class ReservationsController < ApplicationController
  def index
  end

  def new
    @reservation = Reservation.new(reservation_params)
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.host = @listing.user_id
    @reservation.listing_id = @listing.id
    if @reservation.save
    flash[:success] = "Reservation successfully saved! Please proceed to payment stage to finalize your booking."
      # redirect_to reservation_path(@reservation.id), notice: "Successfully booked."
      redirect_to reservation_path(@reservation.id)
    else
    flash[:message] = @reservation.errors.full_messages.join(",")
      render "listings/show", notice: "Error, try again"
    end
  end

  def show
    @client_token = Braintree::ClientToken.generate
    @reservation = Reservation.find(params[:id])
  end

  def checkout
    @reservation = Reservation.find(params[:id])

    # listings = Listing.all.order(:title).page params[:page]
    # user = current_user
    # reservations = Reservation.all
    # @reservation = current_user.reservations.all

    
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    
    result = Braintree::Transaction.sale(
     :amount => @reservation.TotalPrice, #this is currently hardcoded
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
      )
  
    if result.success?
      ReservationMailer.reservation_email(@reservation).deliver_now
      redirect_to profile_Show_path, :flash => { :success => "Transaction successful! Paid #{@reservation.TotalPrice} ringgit!"}
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end


end

private
  def reservation_params
      params.require(:reservation).permit(:check_in, :check_out, :host)
  end

