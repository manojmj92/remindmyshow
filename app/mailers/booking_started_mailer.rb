class BookingStartedMailer < ActionMailer::Base
  default from: "manojmj92@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_started_mailer.booking_started_notification.subject
  #
  def url_builder(movie_link,movie_code)
    "http://in.bookmyshow.com/movies/" + movie_link + "/" + movie_code
  end

  def booking_started_notification(params)
    @url = url_builder(params[:movie_link],params[:movie_code])
    @movie_name = params[:movie_name]
    @location = params[:location_name]

    mail to: params[:email], subject: "Good News! Booking started for " + @movie_name
  end
end
