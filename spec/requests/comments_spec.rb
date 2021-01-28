require 'rails_helper'

RSpec.describe 'コメント機能', type: :request do
  before do
    @user = create(:user)
    @other_user = create(:user)
    @post = create(:post, user: @user)
    @comment = create(:comment, user_id: @user.id, post: @post)
  end

  describe 'コメント作成' do
    context 'ログインしている場合' do
      before do
        sign_in @user
      end

      it '有効な内容のコメントの作成ができること' do
        expect do
          post post_comments_path(@post), params: { post_id: @post.id,
                                                    comment: { content: '最高です！' } }
        end.to change(@post.comments, :count).by(1)
      end

      it '無効な内容のコメントの作成ができないこと' do
        expect do
          post post_comments_path(@post), params: { post_id: @post.id,
                                                    comment: { content: '' } }
        end.not_to change(@post.comments, :count)
      end
    end

    context 'ログインしていない場合' do
      it 'コメントは登録できず、ログインページにリダイレクトすること' do
        expect do
          post post_comments_path(@post), params: { comment: { content: '' } }
        end.not_to change(@post.comments, :count)
        expect(response).to have_http_status '302'
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'コメント削除' do
    context 'ログインしている場合' do
      context 'コメントを作成したユーザーである場合' do
        it 'コメントの削除ができること' do
          sign_in @user
          expect { delete post_comment_path(@post, @comment) }.to change(@post.comments, :count).by(-1)
        end
      end
    end

    context 'コメントを作成したユーザーでない場合' do
      it 'コメントの削除ができないこと' do
        sign_in @other_user
        expect { delete post_comment_path(@post, @comment) }.not_to change(@post.comments, :count)
      end
    end

    context 'ログインしていない場合' do
      it 'コメントの削除ができず、ログインページにリダイレクトすること' do
        expect { delete post_comment_path(@post, @comment) }.not_to change(@post.comments, :count)
        expect(response).to have_http_status '302'
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
