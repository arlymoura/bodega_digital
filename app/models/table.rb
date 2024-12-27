class Table < ApplicationRecord
  # has_many :orders, dependent: :destroy

  enum status: {
    available: 0,  # Mesa disponível
    occupied: 1,   # Mesa ocupada
    closed: 2      # Mesa com conta fechada
  }

  validates :number, presence: true, uniqueness: true, unless: -> { is_virtual }
  validates :status, presence: true

  scope :physical, -> { where(is_virtual: false) }
  scope :virtual, -> { where(is_virtual: true) }
end
