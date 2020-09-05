require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it 'ログインしていない場合、サインインページに移動する' do
    visit root_path

    # ログインしていない場合、サインインページに移動しているはず
    expect(current_path).to eq new_user_session_path
  end

  it 'ログインに成功し、トップページへ行く' do
    # まずはユーザー情報を保存する
    @user = FactoryBot.create(:user)
    visit  new_user_session_path

    # サインインページにいることを確認
    expect(current_path).to eq new_user_session_path

    # さっき保存したユーザーのemailとpasswordを入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password

    click_on("Log in") #ボタンのクリック動作を再現

    # トップページへ行く
    expect(current_path).to eq root_path
  end

  it 'ログインに失敗し、サインインページへと戻される' do
    @user = FactoryBot.create(:user)
    visit  root_path
    expect(current_path).to eq new_user_session_path

    # 誤った情報の入力を再現
    fill_in 'user_email', with: "aaaaa"
    fill_in 'user_password', with: "bbbbb"

    click_on("Log in")

    # サインインページに戻る
    expect(current_path).to eq  new_user_session_path
  end

end