class Task < ApplicationRecord
  belongs_to :user
  belongs_to :custom
end
