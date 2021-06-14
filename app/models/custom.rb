class Custom < ApplicationRecord
  belongs_to :user
  
  # タスクとの連携
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
  
end
