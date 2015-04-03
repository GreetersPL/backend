# == Schema Information
#
# Table name: signups
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  age        :integer
#  activity   :string
#  source     :string
#  expect     :string
#  why        :text
#  places     :text
#  languages  :jsonb
#  flow       :hstore
#  user_lang  :string           default("pl")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'
require 'faker'

RSpec.describe Signup, type: :model do
  it 'has a valid factor' do
    expect(FactoryGirl.create(:signup)).to be_valid
  end

  context 'field name' do
    it 'has to be present' do
      expect(FactoryGirl.build(:signup, name: nil)).not_to be_valid
    end
  end

  context 'field email' do
    it 'has to be present' do
      expect(FactoryGirl.build(:signup, email: nil)).not_to be_valid
    end

    it 'has to be email' do
      expect(FactoryGirl.build(:signup, email: 'testtest')).not_to be_valid
    end

    it 'has to be unique' do
      email = Faker::Internet.email
      FactoryGirl.create(:signup, email: email)
      expect(FactoryGirl.build(:signup, email: email)).not_to be_valid
    end
  end

  context 'field activity' do
    it 'has to be present' do
      expect(FactoryGirl.build(:signup, activity: nil)).not_to be_valid
    end
  end

  context 'field source' do
    it 'has to be present' do
      expect(FactoryGirl.build(:signup, source: nil)).not_to be_valid
    end
  end

  context 'field expect' do
    it 'has to be present' do
      expect(FactoryGirl.build(:signup, expect: nil)).not_to be_valid
    end
  end

  context 'field why' do
    it 'has to be present' do
      expect(FactoryGirl.build(:signup, why: nil)).not_to be_valid
    end

    it 'has to have minimum 100 chars' do
      expect(FactoryGirl.build(:signup, why: Faker::Lorem.characters(99))).not_to be_valid
    end

    it 'has to have maximum 1000 chars' do
      expect(FactoryGirl.build(:signup, why: Faker::Lorem.characters(1001))).not_to be_valid
    end
  end

  context 'field places' do
    it 'has to be present' do
      expect(FactoryGirl.build(:signup, places: nil)).not_to be_valid
    end

    it 'has to have minimum 100 chars' do
      expect(FactoryGirl.build(:signup, places: Faker::Lorem.characters(99))).not_to be_valid
    end

    it 'has to have maximum 1000 chars' do
      expect(FactoryGirl.build(:signup, places: Faker::Lorem.characters(1001))).not_to be_valid
    end
  end

  context 'field languages' do
    it 'has to be present' do
      expect(FactoryGirl.build(:signup, languages: nil)).not_to be_valid
    end

    it 'has to be array' do
      expect(FactoryGirl.build(:signup, languages: {})).not_to be_valid
    end

    it 'has to be proper json' do
      expect(FactoryGirl.build(:signup, languages: [{ test: 'test', test1: 'test' }])).not_to be_valid
    end
  end

  context 'flow' do
    it 'has to have one record after create' do
      expect(FactoryGirl.create(:signup).flow.count).to eq 1
    end
  end
end
