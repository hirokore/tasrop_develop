class User < ApplicationRecord
  # 繋がり機能
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  # デバイス関連
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,:omniauthable, omniauth_providers: %i(google facebook)
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :user
  end
  # ゲストログイン用メソッド
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.vip!
      # 通常ログインができるように
      user.uid = create_unique_string
    end
  end
  # 通常ログインができるように
  def self.create_unique_string
    SecureRandom.uuid
  end
  # 外部から取得したユーザー情報を元に、このアプリで使用するユーザーを作成する
  def self.find_for_oauth(auth)
    user = User.find_by(email: auth.info.email)
    unless user
      user = User.new(email: auth.info.email,
                      provider: auth.provider,
                      uid:      auth.uid,
                      password: Devise.friendly_token[0, 20],
      )
    end
    user.save
    user
  end
end
