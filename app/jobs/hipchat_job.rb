# Hipchat publisher worker
class HipchatJob < ActiveJob::Base
  CLIENT  = HipChat::Client.new(ENV['HIPCHAT_API_TOKEN'], api_version: 'v2')
  HTML = ActionView::Base.new(Rails.root.join('app', 'views'))
  queue_as :hipchat

  rescue_from(HipChat::UnknownResponseCode) do |exception|
    logger.error(exception)
  end
  def perform(*args)
    return if ENV['RAILS_ENV'] == 'test'
    I18n.locale = :pl
    send("send_#{args[0].class.name.downcase}", (args[0]))
    args[0].add_flow('Hipchat message send.')
    args[0].save
  end

  private

  def send_signup(signup)
    HTML.assign(signup: signup)
    message = HTML.render(template: 'hipchat/signup')
    CLIENT[ENV['HIPCHAT_HR_ROOM']].send 'api', message, notify: true, color: 'purple'
  end

  def send_walk(walk)
    HTML.assign(walk: walk)
    message = HTML.render(template: 'hipchat/walk')
    CLIENT[ENV['HIPCHAT_GREETERS_ROOM']].send 'api', message, notify: true, color: 'purple'
  end
end
