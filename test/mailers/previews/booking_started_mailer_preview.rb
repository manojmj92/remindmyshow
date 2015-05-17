# Preview all emails at http://localhost:3000/rails/mailers/booking_started_mailer
class BookingStartedMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_started_mailer/booking_started_notification
  def booking_started_notification
    BookingStartedMailer.booking_started_notification
  end

end
