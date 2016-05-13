module OurnaropaForum
  class UserNotifier < ActionMailer::Base
    default :from => "OurNaropa <info@ournaropa.org>"
    
    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_signup_email(user, domain_base)
      @user = user
      @domain_base = domain_base
      mail( :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => 'Welcome to OurNaropa' )
    end
    
    def send_password_reset_email(user, domain_base)
      @user = user
      @domain_base = domain_base
      mail( :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => '[OurNaropa] Password Recovery' )
    end     
      
  end
end

