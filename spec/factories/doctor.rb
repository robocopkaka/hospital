FactoryBot.define do
  factory :doctor do
    name { Faker::OnePiece.character }
    email { "#{Faker::Name.first_name}@hospital.com" }
    password { 'password' }
  end
end
