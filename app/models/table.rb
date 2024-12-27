class Table < ApplicationRecord
  before_update :set_timestamps

  has_one :order, dependent: :nullify
  has_many :table_items, dependent: :destroy

  enum status: {
    available: 0,  # Mesa disponível
    occupied: 1,   # Mesa ocupada
    closed: 2      # Mesa com conta fechada
  }

  validates :number, presence: true, uniqueness: true, unless: -> { is_virtual }
  validates :status, presence: true

  scope :physical, -> { where(is_virtual: false) }
  scope :virtual, -> { where(is_virtual: true) }

  def time_occupied
    return nil unless occupied_at && closed_at

    Time.at(closed_at - occupied_at).utc.strftime("%H:%M:%S")
  end

  private

  def set_timestamps
    return unless status_changed?

    self.occupied_at = Time.current if occupied? && occupied_at.nil?
    self.closed_at = Time.current if closed?
  end
end
