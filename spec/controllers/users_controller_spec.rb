require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "assigns a new Food to @food" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #show" do
    before :each do
      @user = create(:user)
    end

    it "returns http success" do
      get :show, params: { id: @user.id }
      expect(response).to have_http_status(:success)
    end
    it "renders the :show template" do
      get :show, params: { id: @user.id }
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves new user to the database" do
        expect{
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it "sets a new session for user login automatically" do
        post :create, params: { user: attributes_for(:user) }
        expect(session[:user_id]).not_to eq(nil)
      end

      it "redirects to the show user page" do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(user_path(assigns[:user]))
      end
    end

    context "with invalid attributes" do
      it "does not save new user to the database" do
        expect{
          post :create, params: { user: attributes_for(:invalid_user) }
        }.not_to change(User, :count)
      end

      it "re-renders the :new template" do
        post :create, params: { user: attributes_for(:invalid_user) }
        expect(response).to render_template(:new)
      end
    end
  end
end
