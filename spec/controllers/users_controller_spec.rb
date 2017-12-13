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

      it "sets default gopay_balance to 0.0" do
        post :create, params: { user: attributes_for(:user) }
        expect(assigns[:user].gopay_balance).to eq(0.0)
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

  describe "GET #edit" do
    before :each do
      @user = create(:user)
      @another_user = create(:user)
    end

    context "with logged in user" do
      before :each do
        log_in_as(@user)
        get :edit, params: { id: @user }
      end

      it "assigns the requested user to @user" do
        expect(assigns[:user]).to eq(@user)
      end
      it "renders the :edit template" do
        expect(response).to render_template(:edit)
      end
    end

    context "with non-logged in user" do
      before { get :edit, params: { id: @user } }

      it "redirects to the homepage" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "with different logged-in user" do
      before :each do
        log_in_as(@another_user)
        get :edit, params: { id: @user }
      end
      it "redirects to the homepage" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH #update" do
    context "with non-logged in user" do
      before :each do
        @non_logged_in_user = create(:user)
        patch :update, params: { id: @non_logged_in_user.id, user: attributes_for(:user, name: "Anugrah memang", password: "", password_confirmation: "") }
      end
      it "redirects to the homepage" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "with logged in user" do
      before :each do
        @user = create(:user)
        @another_user = create(:user)
        # log_in_as(@user)
      end

      context "with valid attributes" do
        before :each do
          log_in_as(@user)
          patch :update, params: { id: @user.id, user: attributes_for(:user, name: "Anugrah memang", password: "", password_confirmation: "") }
        end

        it "locates the requested @user" do
          expect(assigns(:user)).to eq(@user)
        end
        it "updates the user's attributes" do
          @user.reload
          expect(@user.name).to match(/Anugrah memang/)
        end
        it "redirects to the user_path" do
          @user.reload
          expect(response).to redirect_to(@user)
        end
      end

      context "with invalid attributes" do
        before :each do
          log_in_as(@user)
          patch :update, params: { id: @user.id, user: attributes_for(:invalid_user, email: "tira@example.com") }
        end

        it "does not update the user" do
          @user.reload
          expect(@user.email).not_to match(/tira@example.com/)
        end
        it "re-renders the :edit template" do
          expect(response).to render_template(:edit)
        end
      end

      context "with different logged-in user" do
        before :each do
          log_in_as(@another_user)
          patch :update, params: { id: @user.id, user: attributes_for(:user, name: "Anugrah memang", password: "", password_confirmation: "") }
        end
        it "redirects to the homepage" do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe "GET #topup_gopay" do
    before :each do
      @user = create(:user)
      get :topup_gopay, params: { id: @user.id }
    end
    it "renders the :topup_gopay template" do
      expect(response).to render_template(:topup_gopay)
    end
    it "locates the requested user to @user" do
      expect(assigns[:user]).to eq(@user)
    end
  end

  describe "PATCH #update_gopay" do
    
  end
end
