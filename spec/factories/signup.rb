require 'faker'

FactoryGirl.define do
  factory :signup do
    name Faker::Name.first_name
    email Faker::Internet.safe_email
    age     { rand(16...25) }
    activity Signup.activity.values.sample
    source Signup.source.values.sample
    expect Signup.expect.values.sample
    why Faker::Lorem.characters(950)
    places Faker::Lorem.characters(950)
    languages [{ language: 'english', level: 'advanced' }]
  end
end
