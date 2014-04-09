class Diver < ActiveRecord::Base
  has_many :dives, through: :diverdive
  has_many :diverdives

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |diver|
      diver.provider = auth.provider
      diver.uid = auth.uid
      diver.name = auth.info.name
      diver.email = auth.info.email
      diver.oauth_token = auth.credentials.token
      diver.oauth_expires_at = Time.at(auth.credentials.expires_at)
      diver.save!
    end
  end

end
