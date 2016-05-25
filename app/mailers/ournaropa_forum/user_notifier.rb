module OurnaropaForum
  class UserNotifier < ActionMailer::Base
    
    add_template_helper(ApplicationHelper)
    include ApplicationHelper
    
    layout '/ournaropa_forum/email'
    
    default :from => "OurNaropa <info@ournaropa.org>"
    
    def init_colors
      @primary_color = "#785a86"
      @highlight_color = "#E18416"
      @faded_color = "#616161"
    end
    
    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_signup_email(user, domain_base = "")
      
      # initialize colors for email
      init_colors
      @user = user
      
      # set footer
      @footer = 'You are received this email because you registered an account.'
      
      mail( :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => 'Welcome to OurNaropa' )
    end
    
    def send_password_reset_email(user, domain_base = "")
      
      # initialize colors for email
      init_colors
      
      @user = user
      
      # set footer
      @footer = 'You are received this email because someone triggered a password reset for your account.'

      
      mail( :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => '[OurNaropa] Password Recovery' )
    end     
      
    def send_new_reply_email(user, reply, domain_base = "")
      
      # initialize colors for email
      init_colors
      
      @user = user
      @reply = reply
      
      @footer = "You received this email because email notifications for this conversation are enabled. *UNSUBSCRIBE_LINK*."

      
      mail( :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => "[OurNaropa] New Reply in #{@reply.conversation.title}" )
          
    end
    
  end
end

