FactoryBot.define do
  factory :specialization do
    name { Faker::Name.first_name }

    factory :specialization_with_doctor do
      after(:create) do |specialization|
        create(:doctor, specialization_id: specialization.id)
      end
    end
  end
end
