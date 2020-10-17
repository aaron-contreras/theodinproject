require 'rails_helper'

RSpec.describe PathsController do
  describe 'GET #show' do
    let!(:path) { create(:path) }

    it 'returns http success' do
      get :show, params: { id: path.id }
      # Get request is  using unnecessary parameters (:id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index, params: { id: path.id.name }
      expect(response).to have_http_status(:success)
    end
  end
end
