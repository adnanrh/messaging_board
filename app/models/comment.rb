class Comment < ApplicationRecord
  include Timestampable
  
  belongs_to :post
  belongs_to :user

  validates :body, presence: true
end
