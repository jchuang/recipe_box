class User < ActiveRecord::Base

  validates :uid, presence: true
  validates :provider, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :recipes, inverse_of: :user, dependent: :destroy
  has_many :comments, inverse_of: :user, dependent: :destroy
  has_many :tags, inverse_of: :user, dependent: :destroy

  def self.from_omniauth(auth)
    find_by(uid: auth['uid'], provider: auth['provider']) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth['uid']
      user.provider = auth['provider']
      user.username = auth['info']['name']
    end
  end

end
