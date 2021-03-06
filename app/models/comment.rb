class Comment < ActiveRecord::Base

  validates :body, presence: true
  validates :recipe, presence: true

  belongs_to :recipe, inverse_of: :comments
  belongs_to :user, inverse_of: :comments

end
