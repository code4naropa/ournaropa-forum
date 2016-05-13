module OurnaropaForum
  # Preview all emails at http://localhost:3000/rails/mailers/user_notifier
  class UserNotifierPreview < ActionMailer::Preview
    def welcome
      UserNotifier.send_signup_email(User.first, "http://localhost:3000")
    end
    
    def forgot_password
      UserNotifier.send_password_reset_email(User.first, "http://localhost:3000")
    end
  end
end
