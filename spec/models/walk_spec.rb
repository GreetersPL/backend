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
#

require 'rails_helper'
require 'faker'

RSpec.describe Walk, type: :model do
  it 'has a valid factor' do
    expect(FactoryGirl.create(:walk)).to be_valid
  end

  it 'is invalid without name' do
    expect(FactoryGirl.build(:walk, name: nil)).to_not be_valid
  end

  it 'is invalid without email' do
    expect(FactoryGirl.build(:walk, email: nil)).to_not be_valid
  end

  it 'is invalid without email format in email' do
    expect(FactoryGirl.build(:walk, email: 'test')).to_not be_valid
  end

  context 'dates field' do
    it 'is invalid without dates' do
      expect(FactoryGirl.build(:walk, dates: 'nil')).to_not be_valid
    end

    it 'has from key in json' do
      expect(FactoryGirl.build(:walk, dates: [{ date: (Time.zone.today + Faker::Number.number(1).to_i.days), to: '10:00' }])).to_not be_valid
    end

    it 'has date key in json' do
      expect(FactoryGirl.build(:walk, dates: [{ from: '8:00', to: '10:00' }])).to_not be_valid
    end

    it 'has bigger hour to than from' do
      expect(FactoryGirl.build(:walk, dates: [{ date: (Time.zone.today + Faker::Number.number(1).to_i.days), to: '10:00', from: '13:00' }])).to_not be_valid
    end
  end

  it 'is invalid without languages' do
    expect(FactoryGirl.build(:walk, languages: nil)).to_not be_valid
  end

  it 'default user_lang is en' do
    expect(FactoryGirl.create(:walk).user_lang).to eq 'en'
  end
end
