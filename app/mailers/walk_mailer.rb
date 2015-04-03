# Walk mailer class
class WalkMailer < ApplicationMailer
  def inform(walk)
    I18n.locale = ENV['GREETERS_LANG']
    @walk = walk
    mail(to: ENV['greeters_group_email'], subject: default_i18n_subject)
  end

  def details(walk)
    @walk = walk
    I18n.locale = determine_language walk
    mail(to: @walk.email, subject: default_i18n_subject)
  end
end
