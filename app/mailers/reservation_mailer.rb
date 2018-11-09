class ReservationMailer < ApplicationMailer
    default from: 'notifications@example.com'
    def reservation_email(reservation)
        @reservation = reservation
        @host = reservation.listing.user
        # @user = user
        mail(to: @host.email,
        subject: 'Igloo BNB Booking Confirmation')
        # template_path: 'user_mailer',
        # template_name: 'welcome_email')
    end
end
