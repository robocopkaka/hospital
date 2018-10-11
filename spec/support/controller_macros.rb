module ControllerMacros
  def login_doctor
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:doctor]
      sign_in FactoryBot.create(:doctor_with_specialization)
    end
  end

  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:doctor]
      specialization = FactoryBot.create(:specialization_with_doctor)
      specialization.doctors.first.update_attributes(admin: true)
      sign_in specialization.doctors.first
    end
  end

  def login_patient
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:patient]
      sign_in FactoryBot.create(:patient)
    end
  end
end
