require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  
  describe "Route for the root" do
    it "routes to static_pages#home" do
      expect(get: root_url(subdomain: nil)).to route_to(controller: "static_pages", action: "home")
    end
  end

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #help" do
    it "returns http success" do
      get :help
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #about" do
    it "returns http status success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET #contact" do
    it "returns http status success" do
      get :contact
      expect(response).to have_http_status(:success)
    end
  end

end
