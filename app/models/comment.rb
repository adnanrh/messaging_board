class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  def timestamp
    created_at.strftime '%Y-%m-%d %H:%M'
  end
end
