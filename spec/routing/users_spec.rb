require 'rails_helper'

RSpec.describe 'Users Routing', type: :routing do
  describe "GET /signup" do
    it "routes to users#new" do
      expect(get("/signup")).to route_to("users#new")
    end
  end
end
