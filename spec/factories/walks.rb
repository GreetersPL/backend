# == Schema Information
#
# Table name: walks
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  dates      :jsonb
#  languages  :jsonb
#  user_lang  :string           default("en")
#  flow       :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  trello_url :string
#

require 'faker'

FactoryGirl.define do
  factory :walk do
    name Faker::Name.first_name
    email Faker::Internet.safe_email
    dates [{ date: (Time.zone.today + Faker::Number.number(1).to_i.days + 1), from: '8:00', to: '10:00' }]
    languages [{ language: 'english', level: 'advanced' }]
  end
end
