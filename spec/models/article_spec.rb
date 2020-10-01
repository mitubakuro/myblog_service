require 'rails_helper'
# binding.pry

RSpec.describe Article, type: :model do
  describe 'articleの新規作成' do
    before do
      @article = FactoryBot.build(:article)
    end

    it 'title, bodyが存在すれば登録できること' do
      expect(@article).to be_valid
    end

    it 'titleが空では登録できないこと' do
      @article.title = ""
      @article.valid?
      expect(@article.errors.full_messages).to include("Titleを入力してください")
    end

    it 'bodyが空では登録できないこと' do
      @article.body = ""
      @article.valid?
      expect(@article.errors.full_messages).to include("Bodyを入力してください")
    end

    it 'ユーザーが紐付いていない投稿は保存できないこと' do
      @article.user = nil
      @article.valid?
      expect(@article.errors.full_messages).to include("Userを入力してください")
    end
  end
end
