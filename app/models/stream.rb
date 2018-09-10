class Stream < ApplicationRecord
  belongs_to :match

  validates :url, presence: true
end
