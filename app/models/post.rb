class Post < ApplicationRecord
  belongs_to :user

  scope :by_recent, -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 250 }

  def timestamp
    created_at.strftime '%Y-%m-%d %H:%M:%S'
  end
end
