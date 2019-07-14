class Product < ApplicationRecord
  belongs_to :admin
  # belongs_to :task
    # validates :name, presence :true
end
