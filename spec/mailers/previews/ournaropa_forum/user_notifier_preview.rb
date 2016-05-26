module OurnaropaForum
  # Preview all emails at http://localhost:3000/rails/mailers/user_notifier
  class UserNotifierPreview < ActionMailer::Preview
    
    include ApplicationHelper
    
    def invitation
      UserNotifier.send_invitation_email(PermittedUser.first, User.last)
    end
    
    def welcome
      u = User.first
      u.reset_token = User.generate_reset_token
      UserNotifier.send_signup_email(u)
    end
    
    def forgot_password
      u = User.first
      u.reset_token = User.generate_reset_token
      UserNotifier.send_password_reset_email(u)
    end
    
    def new_reply
      UserNotifier.send_new_reply_email(User.first, Reply.first)
    end
  end
end
