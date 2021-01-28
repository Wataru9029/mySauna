require 'rails_helper'

RSpec.describe 'フォロー機能', type: :request do
  before do
    @user = create(:user)
    @other_user = create(:user)
  end

  context 'ログインしている場合' do
    before do
      sign_in @user
    end

    it 'ユーザーのフォローがで非同期でできること' do
      expect do
        post relationships_path, xhr: true, params: { relationship: { follow_id: @other_user.id } }
      end.to change(@user.followings, :count).by(1)
    end

    it 'ユーザーのフォロー解除が非同期でできること' do
      @user.follow(@other_user)
      relationship = @user.relationships.find_by(follow_id: @other_user)
      expect do
        delete relationship_path(relationship), xhr: true, params: { relationship: { follow_id: @other_user.id } }
      end.to change(@user.followings, :count).by(-1)
    end
  end

  context 'ログインしていない場合' do
    it 'フォロー中ユーザー一覧ページへ飛ぶとログインページへリダイレクトすること' do
      get followings_user_path(@user.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'フォロワー一覧ページへ飛ぶとログインページへリダイレクトすること' do
      get followers_user_path(@user.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'createアクションは実行できず、ログインページへリダイレクトする' do
      expect do
        post relationships_path
      end.not_to change(@user.followings, :count)
      expect(response).to redirect_to new_user_session_path
    end

    it 'destroyアクションは実行できず、ログインページへリダイレクトする' do
      expect do
        delete relationship_path(@user)
      end.not_to change(@user.followings, :count)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
