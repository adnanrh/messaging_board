class Post < ApplicationRecord
  include Timestampable
  
  belongs_to :user
  has_many :comments

  scope :by_recent, -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 250 }
end
