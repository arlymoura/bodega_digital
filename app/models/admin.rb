class Admin < ApplicationRecord
  # has_secure_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :stores, foreign_key: 'owner_id'
  # belongs_to :team, optional: true
  # has_one :current_store, class_name: 'Store', foreign_key: 'current_member_id'

  enum role: { admin: 0, manager: 1, employee: 2 }
  enum status: { active: 0, inactive: 1 }
  enum document_type: { CPF: 0, CNPJ: 1 }
end
