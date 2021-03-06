class UserMailer < ActionMailer::Base
  default from: 'no-reply@theodinproject.com'

  def send_welcome_email_to(user)
    @user = user
    attachments.inline['logo.svg'] = logo_path
    # Improve action mailer system
    mail(
      subject: 'Getting started with The Odin Project',
      to: user.email,
      template_name: 'welcome_email',
    )
    require 'pry'
    binding.pry
  end

  private

  def logo_path
    File.read(Rails.root.join('app/assets/images/odin-logo.svg'))
  end
end
