module OurnaropaForum

  class UserNotifier < ActionMailer::Base

    include Roadie::Rails::Automatic

    add_template_helper(ApplicationHelper)
    include ApplicationHelper

    layout '/ournaropa_forum/email'

    default :from => "The Cushion <forum@thecushion.org>"

    # invitation email
    def send_invitation_email(new_user, invited_by_user)

      # initialize vars for email
      init_vars
      @new_user = new_user
      @invited_by_user = invited_by_user

      # set footer
      @footer = "You received this email because #{@invited_by_user.first_name} #{@invited_by_user.last_name} invited you to join The Cushion."

      mail( :to => "#{@new_user.first_name} #{@new_user.last_name} <#{@new_user.email}>",
        :subject => 'You are invited to join The Cushion' )

    end

    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_signup_email(user)

      # initialize vars for email
      init_vars
      @user = user

      # set footer
      @footer = 'You received this email because you registered an account.'

      mail( :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => 'Welcome to The Cushion' )
    end

    def send_password_reset_email(user)

      # initialize colors for email
      init_vars

      @user = user

      # set footer
      @footer = 'You received this email because someone triggered a password reset for your account.'

      mail :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
      :subject => '[The Cushion] Password Recovery'
    end

    def send_new_reply_email(user, reply)

      # initialize colors for email
      init_vars

      @user = user
      @reply = reply

      @footer = "You received this email because email notifications for this conversation are enabled. *UNSUBSCRIBE_LINK*."


      mail( :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => "[The Cushion] New Reply in #{@reply.conversation.title}" )

    end

    def send_inactivity_email(user, conversation_ids)

      # initialize colors for email
      init_vars
      @user = user
      @conversations = []

      conversation_ids.each do |id|
        @conversations << Conversation.find(id)
      end

      @footer = "You received this email because email notifications for inactivity are enabled. *UNSUBSCRIBE_LINK*."

      mail( :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => "[The Cushion] It's been a while!" )

    end

    # sends an email to the administrator summarizing the task controller action
    def send_task_summary_email(user, user_ids)

      # initialize variables for email
      init_vars
      @user = user
      @users = []

      user_ids.each do |id|
        @users << User.find(id)
      end

      @footer = "This is an automated email sent by The Cushion's Task Scheduler."

      mail( :to => "#{@user.first_name} #{@user.last_name} <#{@user.email}>",
        :subject => "[The Cushion] Inactivity Emails Were Sent Successfully" )

    end


    private

    def init_vars
      @primary_color = "#785a86"
      @highlight_color = "#E18416"
      @faded_color = "#616161"

      @image_host = ENV["OURNAROPA_ASSET_HOST"]
    end

    def roadie_options

      super unless Rails.env.test?

    end

  end
end
