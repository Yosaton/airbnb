class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :listing
    validate :listing_is_available
    validate :checkin_before_checkout
    validate :dates_are_not_in_the_past


    def listing_is_available
        
        @listings = Listing.find(self.listing_id)
        @listings.reservations.each do |booking|
 
            if (self.check_in..self.check_out).overlaps?(booking.check_in..booking.check_out) && booking != self
            errors.add(:date_overlap, "Your dates overlapped!!!")
            end
        end
    end

def TotalPrice
   self.total_price = (check_out - check_in).to_i * (listing.price)
end

def checkin_before_checkout
    if check_in > check_out
    errors.add(:date_overlap, "You can't checkout before you check in!!!")
    # flash.message = "Post successfully created"
#  else
#     flash.message = "You are a retard"
    end
end

def dates_are_not_in_the_past
    if check_in < DateTime.now.to_date
    errors.add(:reserved_in_past, "You can't check in in the past!!!")
    end
end


end

