module OurnaropaForum
  class UserNotifier < ActionMailer::Base
        
    include Roadie::Rails::Automatic
    
    add_template_helper(ApplicationHelper)
    include ApplicationHelper
        
    layout '/ournaropa_forum/email'
    
    default :from => "OurNaropa <info@ournaropa.org>"
    
    def init_colors
      @primary_color = "#785a86"
      @highlight_color = "#E18416"
      @faded_color = "#616161"
    end
    
    # invitation email
    def send_invitation_email(new_user, invited_by_user)
      
      # initialize vars for email
      init_colors
      @new_user = new_user
      @invited_by_user = invited_by_user
      
      # set footer
      @footer = "You received this email because #{@invited_by_user.first_name} #{@invited_by_user.last_name} invited you to join OurNaropa."
      
      mail( :to => "#{@new_user.first_name} #{@new_user.last_name} <#{@new_user.email}>",
        :subject => 'You are invited to join OurNaropa' )
      
    end
    
    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_signup_email(user)
      
      # initialize vars for email
      init_colors
      @user = user
      
      # set footer
      @footer = 'You received this email because you registered an account.'
      
      mail( :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => 'Welcome to OurNaropa' )
    end
    
    def send_password_reset_email(user)
      
      # initialize colors for email
      init_colors
      
      @user = user
      
      # set footer
      @footer = 'You received this email because someone triggered a password reset for your account.'
            
      mail :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => '[OurNaropa] Password Recovery',
        :skip_premailer => false
    end     
      
    def send_new_reply_email(user, reply)
      
      # initialize colors for email
      init_colors
      
      @user = user
      @reply = reply
      
      @footer = "You received this email because email notifications for this conversation are enabled. *UNSUBSCRIBE_LINK*."

      
      mail( :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => "[OurNaropa] New Reply in #{@reply.conversation.title}" )
          
    end
  
    private

    def roadie_options
      super unless Rails.env.test?
    end
    
  end
end

