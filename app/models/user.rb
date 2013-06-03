class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :omniauthable, :omniauth_providers => [:google_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :avatar, :login, :password, :password_confirmation, :remember_me
  attr_accessor :login

  has_many :photos
  has_many :galleries


  def public_photos
    self.photos.select{|p| p.public}
  end


  def public_galleries
    self.galleries.select{|g| g.public}
  end

  def uncategorized_photos
    self.photos.select{ |p| p.galleries.count == 0 }
  end

  def photos_not_in(gallery)
    self.photos.select do |p|
      p.galleries.include?(gallery) == false
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(username: data["email"],
                         email: data["email"],
                         password: Devise.friendly_token[0,20],
                         avatar: data["image"]
      )
    end
    user
  end
  # attr_accessible :title, :body
end
