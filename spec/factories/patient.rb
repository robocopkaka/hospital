FactoryBot.define do
  factory :patient do
    name { Faker::OnePiece.character }
    password { 'password' }
    email { "#{Faker::Name.first_name}@hospital.com" }
    address { Faker::OnePiece.location }
  end
end
