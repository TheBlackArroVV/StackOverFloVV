class User < ApplicationRecord
  #:lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:github, :twitter]

  has_many :authorizations
  has_many :questions
  has_many :answers
  has_many :votes
  has_many :user_mails

  validates :nickname, presence: true

  def self.find_for_oauth(oauth)
    authorization = Authorization.find_by(provider: oauth[:provider], uid: oauth[:uid].to_s)
    return authorization.user if authorization

    email = oauth[:info][:email]

    if email
      user = User.find_by(email: email)
      unless user
        password = Devise.friendly_token[0, 20]
        user = User.create!(email: email, password: password, password_confirmation: password, nickname: "nickname")
      end
      user.authorizations.create(provider: oauth[:provider], uid: oauth[:uid].to_s)
      user
    end
  end

  def self.other_users(id)
    User.where.not(id: id)
  end
end
