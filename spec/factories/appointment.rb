FactoryBot.define do
  factory :appointment do
    appointment_date { Time.now }
    doctor_id { create(:doctor_with_specialization).id }
    patient_id { create(:patient).id }
    specialization_id { create(:specialization).id }

    # before(:create) do |appointment|
    #   # appointment.doctor_id = create(:doctor_with_specialization).id
    #   # appointment.patient_id = create(:patient).id
    #   appointment.specialization_id = create(:specialization).id
    # end
  end
end
