class User < ActiveRecord::Base

  validates :uid, presence: true
  validates :provider, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :recipes, inverse_of: :user, dependent: :destroy
  has_many :comments, inverse_of: :user, dependent: :destroy
  has_many :tags, inverse_of: :user, dependent: :destroy

end
