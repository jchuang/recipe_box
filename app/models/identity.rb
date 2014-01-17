class Identity < ActiveRecord::Base

  validates :uid, presence: true
  validates :provider, presence: true
  validates :user, presence: true

  belongs_to :user, inverse_of: :identities

end
