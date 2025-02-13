class Category < ApplicationRecord
  belongs_to :account
  belongs_to :company

  has_many :products, dependent: :destroy
  has_one_attached :thumbnail
end
