require 'rails_helper'

RSpec.describe "プロフィール編集", type: :request do
  before do
    @user = create(:user)
    @other_user = create(:user)
  end

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      sign_in @user
      get edit_user_path(@user)
      patch user_path, params: { user: { name: "Example User",
                                         email: "user@example.com",
                                         introduction: "初めまして！" } }
      redirect_to @user
      follow_redirect!
      expect(response).to render_template('users/show')
    end
  end

  context "ログインしていない場合" do
    it "ログイン画面にリダイレクトされること" do
      get edit_user_path(@user)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
      patch user_path, params: { user: { name: "Example User",
                                         email: "user@example.com",
                                         introduction: "初めまして！" } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end
  end

  context "別のアカウントユーザーの場合" do
    it "ホーム画面にリダイレクトされること" do
      sign_in @other_user
      get edit_user_path(@user)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      patch user_path, params: { post: { name: "Example User",
                                         email: "user@example.com",
                                         introduction: "初めまして！" } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
