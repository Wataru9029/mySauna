require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  before do
    @user = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @user4 = create(:user)
    @post = create(:post, user: @user) # 自分が投稿したサウナ施設
    @post2 = create(:post, user: @user2) # フォロー中ユーザーが投稿したサウナ施設
    @post3 = create(:post, user: @user3) # フォローしていないユーザーが投稿したサウナ施設
  end

  describe 'フォロー中ユーザー一覧ページ' do
    before do
      create(:relationship, user_id: @user.id, follow_id: @user2.id)
      create(:relationship, user_id: @user.id, follow_id: @user3.id)
      sign_in @user
      visit followings_user_path(@user)
    end

    context 'ページレイアウト' do
      it '「フォロー中」の文字列が存在すること' do
        expect(page).to have_content 'フォロー中'
      end
    end
  end

  describe 'フォロワー一覧ページ' do
    before do
      create(:relationship, user_id: @user2.id, follow_id: @user.id)
      create(:relationship, user_id: @user3.id, follow_id: @user.id)
      sign_in @user
      visit followers_user_path(@user)
    end

    context 'ページレイアウト' do
      it '「フォロワー」の文字列が存在すること' do
        expect(page).to have_content 'フォロワー'
      end
    end
  end

  describe 'タイムラインページ' do
    before do
      create(:relationship, user_id: @user.id, follow_id: @user2.id)
      sign_in @user
      visit timeline_path
    end

    it 'タイムラインに自分の投稿が含まれていること' do
      expect(@user.feed).to include @post
    end

    it 'タイムラインにフォロー中ユーザーの投稿が含まれていること' do
      expect(@user.feed).to include @post2
    end

    it 'タイムラインにフォローしていないユーザーの投稿が含まれていないこと' do
      expect(@user.feed).not_to include @post3
    end
  end
end
