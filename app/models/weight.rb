class Weight < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, numericality: true
  validates :amount, presence: true, numericality: true
  validates :date, presence: true

  default_scope { order(date: :desc) }

  #weights from today, don't use 1.day.ago ase it adds in timestamp
  scope :today, -> { where('date >= ?', (Date.today -1)) }

  # Most date functions start the week on monday (weird)
  scope :weekly, -> { where('date >= ?', 1.week.ago) }
  scope :monthly, -> { where('date >= ?', 1.month.ago) }

  # more control of individual time frame
  scope :created_after, ->(time) { where('date >= ?', time) if time.present? }
end
