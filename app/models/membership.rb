class Membership < ApplicationRecord
  acts_as_tenant(:company)
  belongs_to :user
  belongs_to :company

  enum role: { member: 0, admin: 1, owner: 2 }
end
