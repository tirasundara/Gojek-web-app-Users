require "rails_helper"

RSpec.describe 'Sessions Routing', type: :routing do
  describe "GET /login" do
    it "routes to sessions#new" do
      expect(get: login_path).to route_to(controller: "sessions", action: "new")
    end
  end

  describe "POST /login" do
    it "routes to sessions#create" do
      expect(post: login_path).to route_to(controller: "sessions", action: "create")
    end
  end

  describe "DELETE /logout" do
    it "routes to sessions#destroy" do
      expect(delete: logout_path).to route_to(controller: "sessions", action: "destroy")
    end
  end
end
