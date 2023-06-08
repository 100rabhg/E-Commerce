require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET index" do
    context "visit home page" do
      it "return a successful responce" do
        get root_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET search" do
    context "visit search page" do
      it "return a successful responce" do
        get search_path, params:{query: "pent"}
        expect(response).to have_http_status(200)
      end
    end
  end

end
