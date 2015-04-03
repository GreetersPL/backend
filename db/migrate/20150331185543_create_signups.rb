class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string :name
      t.string :email

      t.integer :age

      t.string :activity
      t.string :source
      t.string :expect

      t.text :why
      t.text :places

      t.jsonb :languages

      t.hstore :flow
      t.string :user_lang, default: 'pl'

      t.timestamps null: false
    end
  end
end
