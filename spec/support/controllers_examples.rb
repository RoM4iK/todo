module ControllersExamples
  RSpec.shared_examples "a authorized action" do
    it 'should have 403 http status' do
      expect(@response).to have_http_status(403)
    end
    it 'should return error message' do
      expect(JSON.parse(@response.body)).to eq("errors" => ["You are not authorized to access this page."])
    end
  end
end
