class Comment < ApplicationRecord
  include Timestampable
  
  belongs_to :post
  belongs_to :user

  validates :body, presence: true, length: { maximum: 30 }

  def timestamp
    created_at.strftime '%Y-%m-%d %H:%M'
  end
end
