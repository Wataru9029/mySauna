require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user = create(:user)
    @other_user = create(:user)
    @admin_user = create(:user, :admin)
    @post = create(:post, user: @user)
    @other_post = create(:post, user: @other_user)
  end

  describe 'プロフィールページ' do
    context 'ページレイアウト' do
      before do
        sign_in @user
        create_list(:post, 10, user: @user)
        visit user_path(@user)
      end

      it 'ユーザーネームが表示されることを確認' do
        expect(page).to have_css 'h4.show-user-name'
      end

      it 'プロフィール編集ページへのリンクが表示されていることを確認' do
        expect(page).to have_link '編集', href: edit_user_path(@user)
      end

      it 'サウナ投稿の件数が表示されていることを確認' do
        expect(page).to have_css 'h3.user-show-post'
      end

      it 'サウナ投稿の情報が表示されていることを確認' do
        Post.take(5).each do |post|
          expect(page).to have_css '.show-post'
          expect(page).to have_link 'もっとみる'
          expect(page).to have_link '編集'
          expect(page).to have_link '削除'
        end
      end

      it 'サウナ投稿のページネーションが表示されていることを確認' do
        expect(page).to have_css '.pagination'
      end
    end
  end

  describe 'プロフィール編集ページ' do
    before do
      sign_in @user
      visit edit_user_path(@user)
    end

    context 'プロフィール情報の更新処理' do
      it '有効な情報で更新できること' do
        attach_file 'user[image]', "#{Rails.root}/spec/fixtures/test-user2.jpeg"
        fill_in 'ユーザー名', with: '熟練サウナー'
        fill_in 'メールアドレス', with: 'test@gmail.com'
        fill_in 'プロフィール文', with: '初めまして！'
        click_button '編集'
        expect(@user.reload.image.url).to include 'test-user2.jpeg'
      end
    end
  end
end
