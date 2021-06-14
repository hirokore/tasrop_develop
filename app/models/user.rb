class User < ApplicationRecord
  # 写真利用機能
  mount_uploader :image, ImageUploader

  # 繋がり機能
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  # マイタスクカスタマイズ機能
  has_many :customs, dependent: :destroy

  # デバイス関連
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,:omniauthable, omniauth_providers: %i(google facebook)
        #   twitter
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :user
  end
  # ゲストログイン用メソッド
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
      user.name_tag = name_tag
      user.uid = create_unique_string
      user.vip!
      # 通常ログインができるように
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
                      name: auth.info.name,
                      name_tag: name_tag,
                      provider: auth.provider,
                      uid:      auth.uid,
                      password: Devise.friendly_token[0, 20],
      )
    end
    user.save
    user
  end
  #指定のユーザをフォローする
  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end
  #フォローしているかどうかを確認する
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end
  #指定のユーザのフォローを解除する
  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def self.name_tag
    rand(1..9999)
  end

  # パスワード入力なしで更新
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

end
