require 'rails_helper'

RSpec.describe SpecializationsController, type: :request do
  let!(:test_specialization) { create :specialization }
  let!(:specialization) do
    { specialization: attributes_for(:specialization) }
  end
  describe 'GET #new' do
    it 'renders the new template' do
      get new_specialization_path
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'saves a new specialization and redirect to the home page' do
      post specializations_path, params: specialization
      expect(response).to redirect_to :specializations
      follow_redirect!
    end

    it 'should render the new template if something went wrong' do
      specialization[:specialization][:name] = nil
      post specializations_path, params: specialization
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get edit_specialization_path(test_specialization.id)
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    it 'should redirect to the home page if the update is successful' do
      put specialization_path(test_specialization.id), params: specialization
      expect(response).to redirect_to :specializations
      follow_redirect!
    end

    it 'should render the edit template if something went wrong' do
      specialization[:specialization][:name] = nil
      put specialization_path(test_specialization.id), params: specialization
      expect(response).to render_template :edit
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete the specialization from the database' do
      expect do
        delete specialization_path(test_specialization.id)
      end.to change(Specialization, :count).by(-1)
    end

    it 'redirects to the home page if a delete attempt is successful' do
      delete specialization_path(test_specialization.id)
      expect(response).to redirect_to :root
      follow_redirect!
    end
  end
end
