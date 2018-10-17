require 'rails_helper'

RSpec.describe HomeController, type: :request do

  describe 'GET #index' do
    it 'returns the index page' do
      get home_index_path
      expect(response).to render_template :index
    end
  end
end
