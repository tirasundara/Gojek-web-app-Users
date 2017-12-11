require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET /signup" do
    it "routes to users#new" do
      expect(get: signup_path).to route_to(controller: "users", action: "new")
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

end
