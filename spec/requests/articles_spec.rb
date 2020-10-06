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

    it "indexアクションにリクエストするとレスポンスに投稿済み記事のタイトルが存在する" do 
      get root_path
      expect(response.body).to include @article.title
    end

    it "indexアクションにリクエストするとレスポンスにログインボタンが存在する" do 
      get root_path
      expect(response.body).to include "ログイン"
    end
  end
end
