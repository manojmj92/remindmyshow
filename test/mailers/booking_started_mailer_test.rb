require 'test_helper'

class BookingStartedMailerTest < ActionMailer::TestCase
  test "booking_started_notification" do
    mail = BookingStartedMailer.booking_started_notification
    assert_equal "Booking started notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
