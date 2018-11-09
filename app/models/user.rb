class User < ApplicationRecord
  enum role: [:superadmin, :moderator, :customer]
  # attr_accessible :avatar
  # paginates_per 10
  include Clearance::User
  mount_uploader :avatar, AvatarUploader
  has_many :authentications, dependent: :destroy
  has_many :listings, dependent: :destroy #when you remove a listing, also removes the user associated with it
#if you delete user, all his listings also deleted (because listings is dependent on user)
  has_many :reservations, dependent: :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      first_name: auth_hash["info"]["first_name"],
      last_name: auth_hash["info"]["last_name"],
      email: auth_hash["info"]["email"],
      password: SecureRandom.hex(10)
    )
    user.authentications << authentication
    return user
  end
 
  # grab google to access google for user data
  def google_token
    x = self.authentications.find_by(provider: 'google_oauth2')
    return x.token unless x.nil?
  end
end
