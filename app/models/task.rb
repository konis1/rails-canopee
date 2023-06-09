class Task < ApplicationRecord
  belongs_to :garden_plant
  has_one :garden, through: :garden_plant
  has_one :plant, through: :garden_plant
  after_create_commit :notify_recipient

  has_noticed_notifications

  scope :watering, -> { where(activity: 'Arrose-moi !') }
  scope :mulching, -> { where(activity: 'Paille-moi !') }
  scope :repotting, -> { where(activity: 'Rempote-moi !') }
  scope :covering, -> { where(activity: 'Couvre-moi !') }
  scope :sheltering, -> { where(activity: "Rentre-moi à l'intérieur !") }
  scope :urgent, -> { where(criticity: 2) }
  scope :pending, -> {
    where(done_time: nil)
      .where('due_date > ?', Date.today)
  }
  scope :done, -> {
    where.not(done_time: nil)
         .where('due_date > ?', Date.today)
  }

  scope :watered_recently, -> {
    where.not(done_time: nil)
         .left_joins(garden_plant: :plant)
         .where(
           plant: { water_need: 0 }
         ).and(where('done_time < ?', Date.today - 31.days))
         .or(
           where(
             plant: { water_need: 1 }
           ).and(where('done_time < ?', Date.today - 7.days))
         )
         .or(
           where(
             plant: { water_need: 2 }
           ).and(where('done_time < ?', Date.today - 1.days))
         )
  }

  scope :near_future, -> {
    where(done_time: nil, due_date: (Date.today..Date.today + 30.days))
  }

  def criticity_name
    case criticity
      when 0 then "low"
      when 1 then "medium"
      when 2 then "high"
    end
  end

  private

  def notify_recipient
    TaskNotification.with(task: self).deliver_later(garden_plant.garden.user)
  end
end
