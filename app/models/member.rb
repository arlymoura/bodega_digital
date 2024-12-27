class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 0, manager: 1, employee: 2 }
  enum status: { active: 0, inactive: 1 }
  enum document_type: { CPF: 0, CNPJ: 1 }
end
