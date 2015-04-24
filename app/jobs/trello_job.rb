class TrelloJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    @walk = args[0]
    description = generate_description
    puts description
    @card = Trello::Card.create( :name => @walk.name, :list_id => ENV['TRELLO_WALKS_NEW_LIST_ID'], :desc=>description.to_str )
    @walk.trello_url = @card.short_url
    @walk.add_flow 'Publicated on Trello.'
    @walk.save
    @walk
  end

  private

  def generate_description
    I18n.locale = ENV['GREETERS_LANG']
    md = ActionView::Base.new(Rails.root.join('app', 'views'))
    md.assign(:walk => @walk)
    md.render(template: 'trello/walk')
  end
end
