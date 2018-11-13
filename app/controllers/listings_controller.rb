class ListingsController < ApplicationController
    
    def index
        @user = current_user
        @listings = Listing.all.order(:title)
        
        if params[:search]
            @listings = Listing.omnisearch(params[:search])
            # @listings = Listing.abc(params[:search])
            #this is my scope (as listing.rb scope)
            #scope is just
        end
        @listings = @listings.page(params[:page])
        respond_to do |format|
            format.html
            format.js
        end
    end

    def new
    end

    def edit
        @listing = Listing.find(params[:id])
    end

    def create
        @listing = Listing.new(article_params)
        @listing.user_id = current_user.id
        @listing.save!
        redirect_to users_path
    end

    def show
    @listing = Listing.find(params[:id])
    @reservation = Reservation.new
    @reservation.listing_id = @listing.id
    #actually the reservation form exists on the listings/show page
    end

    def update
        @listing = Listing.find(params[:id])
       
        if @listing.update(article_params)
          redirect_to users_path
        else
          render 'edit'
        end
    end

    def destroy
        @listing = Listing.find(params[:id])
        @listing.destroy
        redirect_to users_path
    end

    def verify
        @listing = Listing.find(params[:id])
        if current_user.superadmin?
        @listing.update(verification:true)
        flash[notice] = "Successfully verified!"
        redirect_to users_path
        end
    end

    # def search
    #     @user = current_user
    #     @listings = Listing.city(params[:search])
        
    #     # render '/users/index'
    # end

    private
    def article_params
        params.require(:listing).permit(:title, :address , :price, {images:[]})
    end
end
