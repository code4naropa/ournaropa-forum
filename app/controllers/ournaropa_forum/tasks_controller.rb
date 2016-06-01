require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class TasksController < ApplicationController
    
    def send_inactivity_emails
      redirect_to root_path and return unless params[:webhook_key] == ENV["WEBHOOK_KEY"]
      
      # send email
      users = User.all
      user_ids = []
      
      conversations = Conversation.where("created_at > ?", Time.now - 7.days).order(updated_at: :desc).limit(3)
      conversation_ids = []
      conversations.each do |conversation|
        conversation_ids << conversation.id
      end
      
      if conversations.any?
      
        users.each do |user|
          if user.is_receiving_inactivity_email
            if user.seen_at.nil? || user.seen_at < Time.now - 7.days
              if user.inactivity_email_sent_at.nil? || user.inactivity_email_sent_at < Time.now - 7.days

                # email them  
                email = UserNotifier.send_inactivity_email(user, conversation_ids)
                email.deliver_later

                # update last email sent
                user.touch(:inactivity_email_sent_at)
                
                user_ids << user.id

              end
            end
          end
        end
        
      end
      
      # email devs
      developers = User.where(:is_developer => true)
      
      developers.each do |dev|
        email = UserNotifier.send_task_summary_email(dev, user_ids)
        email.deliver_later
      end
        
    end
  end
end
