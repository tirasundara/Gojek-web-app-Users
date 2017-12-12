require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let!(:user) { create(:user, email: "user@example.com", password: "12345678", password_confirmation: "12345678") }

    context "with valid attributes" do
      let(:session_params) { { email: user.email, password: user.password } }
      before { post :create, params: { session: session_params } }

      it "creates new session[:user_id] = user.id" do
        expect(session[:user_id]).to eq(user.id)
      end
      it "redirects to users#show" do
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid attributes" do
      let(:invalid_session_params) { { email: user.email, password: "87654123" } }
      before { post :create, params: { session: invalid_session_params } }

      it "does not create a new session" do
        expect(session[:user_id]).to eq(nil)
      end
      it "sets flash's message" do
        expect(flash[:danger]).to match(/Invalid email\/password combination./)
      end
      it "re-renders the :new template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes session[:user_id]" do
      session[:user_id] = 1
      delete :destroy
      expect(session[:user_id]).to eq(nil)
    end
    it "redirects to homepage" do
      session[:user_id] = 1
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
