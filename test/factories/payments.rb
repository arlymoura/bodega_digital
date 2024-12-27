FactoryBot.define do
  factory :payment do
    order { nil }
    amount { "9.99" }
    payment_method { "MyString" }
    status { 1 }
  end
end
