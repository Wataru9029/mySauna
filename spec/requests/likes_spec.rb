require 'rails_helper'

RSpec.describe "いいね機能", type: :request do
  before do
    @user = create(:user)
    @post = create(:post, user: @user)
  end

  describe "お気に入り記事一覧ページの表示" do
    context "ログインしている場合" do
      it " レスポンスが正常にされること" do
        sign_in @user
        get favorites_path
        expect(response).to have_http_status "200"
        expect(response).to render_template('posts/favorites')
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        get favorites_path
        expect(response).to redirect_to new_user_session_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "お気に入り登録処理" do
    context "ログインしている場合" do
      before do
        sign_in @user
      end

      it "サウナ施設のお気に入り登録&解除が非同期でできること" do
        expect do
          post post_likes_path(@post), xhr: true
        end.to change(@user.likes, :count).by(1)

        like = Like.first

        expect do
          delete post_like_path(@post, like), xhr: true
        end.to change(@user.likes, :count).by(-1)
      end
    end
  end
end
