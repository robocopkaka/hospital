FactoryBot.define do
  factory :doctor do
    name { Faker::OnePiece.character }
    email { "#{Faker::Name.first_name}@hospital.com" }
    password { 'password' }

    factory :doctor_with_specialization do
      before(:create) do |doctor|
        doctor.specialization_id = create(:specialization).id
      end
    end
  end
end
