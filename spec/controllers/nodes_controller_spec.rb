require 'rails_helper'

RSpec.describe NodesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      skip
      login_user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      skip
      login_user
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      skip
      login_user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      skip
      login_user
      #get :create
      #expect(response).to have_http_status(:success)
    end
  end
  
end
