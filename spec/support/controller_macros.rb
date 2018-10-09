module ControllerMacros
  def login_doctor
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:doctor]
      sign_in FactoryBot.create(:doctor) # Using factory bot as an example
    end
  end

  def login_patient
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:patient]
      sign_in FactoryBot.create(:patient)
    end
  end
end
