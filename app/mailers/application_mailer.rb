# Basic mailer class
class ApplicationMailer < ActionMailer::Base
  default from: 'api@greeters.pl'
  layout 'mailer'

  private

  def determine_language(object)
    if I18n.available_locales.include? object.user_lang.to_sym
      object.user_lang
    else
      I18n.default_locale
    end
  end
end
