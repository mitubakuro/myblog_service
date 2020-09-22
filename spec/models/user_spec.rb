require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'userの新規作成' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nicknameやemail、firstname、lastname、birthday、password、password_confirmationが存在すれば登録できること" do
      expect(@user).to be_valid
    end

    it "nicknameが空では登録できないこと" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("ユーザー名を入力してください")
    end

    it "emailが空では登録できないこと" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end

    it "passwordが空では登録できないこと" do

    end
    it "passwordが存在してもpassword_confirmationが空では登録できないこと" do

    end
  end


end
