# == Schema Information
#
# Table name: entries
#
#  id         :uuid             not null, primary key
#  player_id  :uuid
#  scrum_id   :uuid
#  category   :string
#  body       :text
#  points     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Entry < ActiveRecord::Base

  belongs_to :player
  belongs_to :scrum

  scope :current, -> { where(created_at: Date.today.beginning_of_day..Date.today.end_of_day) }

  after_create :tally

  def tally
    cron = CronParser.new(scrum.team.summary_at)
    entries_due_at = cron.last(Time.now)

    if created_at < ActiveSupport::TimeZone.new(scrum.team.timezone).local_to_utc(entries_due_at)
      write_attribute :points, 5
    end

    scrum.tally
  end

end
