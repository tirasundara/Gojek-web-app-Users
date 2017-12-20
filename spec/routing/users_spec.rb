require 'rails_helper'

RSpec.describe 'Users Routing', type: :routing do
  describe "GET /signup" do
    it "routes to users#new" do
      expect(get("/signup")).to route_to("users#new")
    end
  end

  describe "GET /users/:id/topup" do
    it "routes to users#topup_gopay" do
      expect(get: "/users/1/topup").to route_to("users#topup_gopay", id: '1')
    end
  end

  describe "PATCH /users/:id/topup" do
    it "routes to users#update_gopay" do
      expect(patch("/users/1/topup")).to route_to("users#update_gopay", id: '1')
    end
  end

  describe "GET /users/:id/orders/history" do
    it "routet to users#orders_history" do
      expect(get("/users/1/orders/history")).to route_to("users#orders_history", id: '1')
    end
  end
end
