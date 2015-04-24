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

# Signup model class
class Signup < ActiveRecord::Base
  extend Enumerize
  enumerize :activity, in:  [:pupil, :student, :job]
  enumerize :source, in: [:friends, :internet, :facebook, :other_source]
  enumerize :expect, in: [:fun, :people, :passion, :devel, :qualifications, :other_expect]
  validates :name, :email, :age, :activity, :source, :expect, :why, :places, :languages, presence: true
  validates :email, email: true, uniqueness: true
  validates :why, :places, length: { maximum: 1000, minimum: 100 }
  validates :languages, languages_json_schema: true
  before_create :add_create_flow
  after_create :inform_hr, :thanks_for_registration

  def add_flow(message)
    flow[Time.new.to_s] = message
  end

  private

  def add_create_flow
    self.flow = { Time.new.to_s => 'Created new application by api request.' }
  end

  def inform_hr
    SignupMailer.inform_hr(self).deliver_now
    HipchatJob.perform_later(self)
  end

  def thanks_for_registration
    SignupMailer.thanks(self).deliver_now
  end
end
