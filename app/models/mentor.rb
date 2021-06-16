class Mentor < ApplicationRecord
  belongs_to :user
  # カスタム
  # has_many :customs, dependent: :destroy
end
