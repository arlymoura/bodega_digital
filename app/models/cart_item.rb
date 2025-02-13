class CartItem < ApplicationRecord
  belongs_to :account
  belongs_to :company
  belongs_to :cart
end
