require 'rails_helper'
# binding.pry


RSpec.describe User, type: :model do
  describe 'userの新規作成' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nicknameやemail、firstname、lastname、birthday、password、password_confirmationが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include('ユーザー名を入力してください')
    end

    it 'emailが空では登録できないこと' do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールを入力してください')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワード（確認用）とパスワードの入力が一致しません")
    end

    it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end

    it 'firstnameが空では登録できないこと' do
      @user.firstname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstnameを入力してください")
    end

    it 'lastnameが空では登録できないこと' do
      @user.lastname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastnameを入力してください")
    end

    it 'birthdayが空では登録できないこと' do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthdayを入力してください")
    end
  end
end
