require 'rails_helper'

RSpec.describe 'サウナ施設新規作成', type: :request do
  before do
    @user = create(:user)
    @other_user = create(:user)
    @post = create(:post, user: @user)
    @other_post = create(:post, user: @other_user)
  end

  describe '通知一覧ページの表示' do
    context 'ログイン済みユーザーの場合' do
      it 'レスポンスが正常に表示されること' do
        sign_in @user
        get notifications_path
        expect(response).to render_template('notifications/index')
      end
    end

    context 'ログインしていないユーザーの場合' do
      it 'ログインページへリダイレクトすること' do
        get notifications_path
        expect(response).to have_http_status '302'
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '通知処理' do
    before do
      sign_in @user
    end

    context '自分以外のユーザーのサウナ投稿に対して' do
      it 'いいね登録によって通知が作成されること' do
        expect do
          post post_likes_path(@other_post), xhr: true
        end.to change(@other_post.notifications, :count).by(1)
      end

      it 'コメントによって通知が作成されること' do
        expect do
          post post_comments_path(@other_post), params: { post_id: @other_post.id,
                                                          comment: { content: '最高です！' } }
        end.to change(@other_post.notifications, :count).by(1)
      end
    end

    context '自分のサウナ投稿に対して' do
      it 'いいね登録によって作成される通知が通知済みであること' do
        expect do
          post post_likes_path(@post), xhr: true
        end.to change(@post.notifications, :count).by(1)
        expect(@post.notifications.first.checked).to eq true
      end

      it 'コメントによって作成される通知が通知済みであることと' do
        expect do
          post post_comments_path(@post), params: { post_id: @other_post.id,
                                                    comment: { content: '最高です！' } }
        end.to change(@post.notifications, :count).by(1)
        expect(@post.notifications.first.checked).to eq true
      end
    end
  end
end
