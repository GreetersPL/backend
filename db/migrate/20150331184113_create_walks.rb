class CreateWalks < ActiveRecord::Migration
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')

    create_table :walks do |t|
      t.string :name
      t.string :email
      t.jsonb :dates
      t.jsonb :languages
      t.string :user_lang, default: 'en'
      t.hstore :flow
      t.timestamps null: false
    end
  end
end
