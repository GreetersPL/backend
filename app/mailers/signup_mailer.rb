# Signup mailer class
class SignupMailer < ApplicationMailer
  default from: 'hr@greeters.pl'

  def inform_hr(signup)
    @signup = signup
    I18n.locale = ENV['GREETERS_LANG']
    mail(to: ENV['greeters_hr_email'], subject: default_i18n_subject)
  end

  def thanks(signup)
    I18n.locale = determine_language(signup)
    @signup = signup
    mail(to: @signup.email, subject: default_i18n_subject)
  end
end
