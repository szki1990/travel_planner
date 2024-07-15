class Category < ApplicationRecord
  belongs_to :check_list
  has_many :items, dependent: :destroy
end
