require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nameとemail、passwordとpassword_confirmationがあれば保存できる" do
      expect(@user).to be_valid
      #be_validはexpectの値が正しく保存されるかみてくれる
    end

    it "nameが空だと保存できない" do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
      #includeでエラーメッセージに()の内容があるか確認
    end

    it "emailが空では保存できない" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "passwordが空では保存できない" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "password_confirmationが空では保存できない" do
      @user.password_confirmation = ""
      #↑nilと記述すると"nil"として認識してしまう
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "passwordが6文字以上なら保存できる" do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      expect(@user).to be_valid
    end

    it "passwordが5文字以下なら出来ない" do
      @user.password = "12345"
      @user.password_confirmation = "12345"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "重複したemailだと保存不可" do
      @user.save
      #ここで一度生成した値を保存
      another_user = FactoryBot.build(:user, email: @user.email)
      #メールアドレスだけを生成して変数に代入
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end


  end
end