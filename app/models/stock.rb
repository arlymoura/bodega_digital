# frozen_literal: true

class Stock < ApplicationRecord
  belongs_to :account
  belongs_to :company
  has_many :stock_items, dependent: :destroy
  has_many :variants, through: :stock_items
  has_many :products, through: :variants

  enum status: { active: 0, disabled: 1 }

  validate :only_one_active_stock, on: [:create, :update]

  private

  def only_one_active_stock
    errors.add(:status, "Já existe um estoque ativo.") if status == "active" && Stock.active.exists?
  end
end
