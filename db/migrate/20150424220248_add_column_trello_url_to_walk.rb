class AddColumnTrelloUrlToWalk < ActiveRecord::Migration
  def change
    add_column(:walks, 'trello_url', :string)
  end

  def down
    remove_column(:walks, 'trello_url')
  end
end
