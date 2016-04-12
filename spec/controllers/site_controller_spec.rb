require 'rails_helper'

RSpec.describe SiteController, type: :controller do
  describe '#index' do
    it 'must render index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
