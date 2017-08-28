class Weight < ApplicationRecord
  belongs_to :user

  default_scope { order(date: :desc) }
end
