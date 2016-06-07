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
      UserNotifier.send_new_reply_email(User.first, Conversation.first.replies.last)
    end

    def inactivity_email

      conversations = OurnaropaForum::Conversation.where("created_at > ?", Time.now - 7.days).order(updated_at: :desc).limit(3)

      UserNotifier.send_inactivity_email(User.first, conversations)
    end

    def task_summary

      developer = User.find_by is_developer: true

      users = OurnaropaForum::User.where(:is_receiving_inactivity_email => true).where("seen_at IS NULL or seen_at < ?", Time.now - 7.days).where("inactivity_email_sent_at IS NULL or inactivity_email_sent_at < ?", Time.now - 7.days)
      users_emailed = []

      users.each do |user|
        users_emailed << user.id
      end

      UserNotifier.send_task_summary_email(developer, users_emailed)
    end

  end
end
