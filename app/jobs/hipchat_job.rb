# Hipchat publisher worker
class HipchatJob < ActiveJob::Base
  HTML = ActionView::Base.new(Rails.root.join('app', 'views'))
  queue_as :hipchat

  rescue_from(HipChat::UnknownResponseCode) do |exception|
    logger.error(exception)
  end

  def perform(*args)
    message_type = args[0].class.name
    message = generate_message(message_type, args[0])
    set_message_to_hipchat(message_type, message)
    args[0].add_flow('Hipchat message send.')
    args[0].save
  end

  private

  def generate_message(message_type, elem)
    I18n.locale = ENV['GREETERS_LANG']
    HTML.assign("#{message_type.downcase}": elem)
    HTML.render(template: "hipchat/#{message_type.downcase}")
  end

  def set_message_to_hipchat(message_type, message)
    client = HipChat::Client.new(ENV["HIPCHAT_#{message_type.upcase}_TOKEN"],
                                 api_version: 'v2'
                                )
    client[ENV["HIPCHAT_#{message_type.upcase}_ROOM"]].send('api', message,
                                                            notify: true,
                                                            color: 'purple'
                                                           )
  end
end
