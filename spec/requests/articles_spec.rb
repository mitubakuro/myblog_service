require 'rails_helper'

RSpec.describe "Articles", type: :request do
  before do
    @article = FactoryBot.create(:article)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get root_path
      expect(response.status).to eq 200
    end
  end
end
