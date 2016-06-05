require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class TasksController < ApplicationController
    
    def send_inactivity_emails
      
      # make sure that the webhook key is accurate, otherwise we're dealing with unauthorized access
      redirect_to root_path and return unless params[:webhook_key] == ENV["WEBHOOK_KEY"]
            
      # get three conversations from the last 7 days
      conversations = Conversation.where("created_at > ?", Time.now - 7.days).order(updated_at: :desc).limit(3)

      users_emailed = []

      if conversations.any?

        # create an array of the conversation ids
        conversation_ids = []
        conversations.each do |conversation|
          conversation_ids << conversation.id
        end
        
        # determine who to email
        users = OurnaropaForum::User.where(:is_receiving_inactivity_email => true).where("seen_at IS NULL or seen_at < ?", Time.now - 7.days).where("inactivity_email_sent_at IS NULL or inactivity_email_sent_at < ?", Time.now - 7.days)
        
        # begin email procedure
        users.each do |user|

          # email them  
          email = UserNotifier.send_inactivity_email(user, conversation_ids)
          email.deliver_later

          # update last email sent
          user.touch(:inactivity_email_sent_at)
                
          # add users to this array for the summary for the developer
          users_emailed << user.id
          
        end
        
      end
      
      # get devs and email them a summary about what happened
      developers = User.where(:is_developer => true)
      developers.each do |dev|
        email = UserNotifier.send_task_summary_email(dev, users_emailed)
        email.deliver_later
      end
        
    end
  end
end
