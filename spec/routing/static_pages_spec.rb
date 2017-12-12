require 'rails_helper'

RSpec.describe "Static Pages Routing", type: :routing do
  describe "GET /" do
    it "routes to static_pages#home" do
      expect(get("/")).to route_to("static_pages#home")
    end
  end

  describe "GET /contact" do
    it "routes to static_pages#contact" do
      expect(get("/contact")).to route_to("static_pages#contact")
    end
  end

  describe "GET /about" do
    it "routes to static_pages#about" do
      expect(get("/about")).to route_to("static_pages#about")
    end
  end

  describe "GET /help" do
    it "routes to static_pages#help" do
      expect(get("/help")).to route_to("static_pages#help")
    end
  end
end
