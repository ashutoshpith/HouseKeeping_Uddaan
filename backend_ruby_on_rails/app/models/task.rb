class Task < ApplicationRecord
  # belongs_to :admin
  has_many :products,dependent: :destroy
  # validates :name, presence :true
end
