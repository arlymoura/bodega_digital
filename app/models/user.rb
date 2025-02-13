class User < ApplicationRecord
  # acts_as_tenant(:company)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_many :orders
  belongs_to :account, optional: true
  belongs_to :current_company, class_name: 'Company', optional: true

  has_many :memberships
  has_many :companies, through: :memberships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Define uma associação dinâmica com o Membership da current_company
  def current_membership
    memberships.find_by(company: current_company)
  end

  def multiple_companies?
    companies.count > 1
  end
end
