require 'rails_helper'

RSpec.describe TechnologiesController, type: :controller do
  login_user
  let(:portfolio) { subject.current_user.portfolios.create(url: 'mytest') }

  describe "GET #create" do
    it "returns http success" do
    end
  end

  describe "GET #update" do
    it "returns http success" do
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
    end
  end

end
