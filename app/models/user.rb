class User < ActiveRecord::Base
  validates :uid,   uniqueness: { scope: :provider }
  validates :token, presence: true

  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth[:provider],
                                  uid: auth[:uid])
    user.token        = auth[:credentials][:token]
    user.full_name    = auth[:extra][:raw_info][:user][:fullName]
    user.avatar       = auth[:extra][:raw_info][:user][:avatar]
    user.display_name = auth[:extra][:raw_info][:user][:displayName]

    user.save

    user
  end
end
