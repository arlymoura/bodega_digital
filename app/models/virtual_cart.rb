class VirtualCart < ApplicationRecord
  belongs_to :account
  belongs_to :company

  has_many :carts, dependent: :destroy
end
