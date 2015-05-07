require_relative 'production'

Mail.register_interceptor(
  RecipientInterceptor.new(ENV.fetch('EMAIL_RECIPIENTS'))
)

Rails.application.configure do
  # ...

  config.action_mailer.default_url_options = { host: ENV.fetch('HOST') }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :port           => ENV['MAILGUN_SMTP_PORT'],
      :address        => ENV['MAILGUN_SMTP_SERVER'],
      :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
      :password       => ENV['MAILGUN_SMTP_PASSWORD'],
      :domain         => 'greeterspl.heroku.com',
      :authentication => :plain,
  }
end
