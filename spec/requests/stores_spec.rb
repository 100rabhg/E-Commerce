require 'rails_helper'

RSpec.describe "Store", type: :request do
  describe "GET show" do
    context "when user is authenticated" do
      before(:each) do
        user = FactoryBot.create(:user, :merchant)
        sign_in user
      end
      it "return a successful responce" do
        get store_path
        expect(response).to have_http_status(200)
      end
    end

    context "when user is not authenticated" do
      it "it redirected to ther login page" do
        get store_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end
end
