class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable,
         :timeoutable, :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]
  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.name auth.info.name
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #   end
  # end
  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first
    if user.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    else
      user = User.new(
        name: auth.info.name,
        email: auth.info.email
      )
      sns = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    return { user: user ,sns: sns}
  end

  def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        name: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
  end

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end

  # def self.from_omniauth(auth)
  #   user = User.find_by(uid: auth.uid, provider: auth.provider)

  #   user ||= User.create!(
  #     uid: auth.uid,
  #     provider: auth.provider,
  #     name: "ゲスト",
  #     email: User.dummy_email(auth),
  #     password: Devise.friendly_token[0, 20]
  #   )

  #   user
  # end

  # # ダミーのメールアドレスを作成
  # def self.dummy_email(auth)
  #   "#{Time.now.strftime('%Y%m%d%H%M%S').to_i}-#{auth.uid}-#{auth.provider}@example.com"
  # end

  # def self.from_omniauth(auth)
  #   where(uid: auth.uid).first
  # end

  # def self.new_with_session(_, session)
  #   super.tap do |user|
  #     if (data = session['devise.omniauth_data'])
  #       user.email = data['email'] if user.email.blank?
  #       user.provider = data['provider'] if data['provider'] && user.provider.blank?
  #       user.uid = data['uid'] if data['uid'] && user.uid.blank?
  #       user.skip_confirmation!
  #     end
  #   end
  # end

  has_one_attached :avatar

  # validates :name, presence: true
  validates :email, {presence: true, uniqueness: true }
  validates :profile, length: { maximum: 200 }

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def projects
    return Project.where(user_id: self.id)
  end
end
