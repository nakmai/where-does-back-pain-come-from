require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'welcome_email' do
    user = users(:one) # fixtureでサンプルユーザーを用意する
    mail = UserMailer.welcome_email(user)

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal ['no-reply@yourdomain.com'], mail.from
    assert_equal [user.email], mail.to
    assert_equal 'Welcome to My Awesome Site', mail.subject
  end
end
