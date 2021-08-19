require 'rails_helper'

RSpec.describe "Tops", type: :request do
  describe "GET /index" do
    it "responds successfully" do
      get "/"
      expect(response).to be_successful
    end
  end
end
