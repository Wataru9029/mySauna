require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = create(:user)
    @other_user = create(:user)
    @admin_user = create(:user, :admin)
    @post = create(:post, user: @user)
    @other_post = create(:post, user: @other_user)
  end

  describe "プロフィールページ" do
    context "ページレイアウト" do
      before do
        sign_in @user
        create_list(:post, 10, user: @user)
        visit user_path(@user)
      end

      it "ユーザーネームが表示されることを確認" do
        expect(page).to have_css "h4.show-user-name"
      end

      it "プロフィール編集ページへのリンクが表示されていることを確認" do
        expect(page).to have_link '編集', href: edit_user_path(@user)
      end

      it "サウナ投稿の件数が表示されていることを確認" do
        expect(page).to have_css "h3.user-show-post"
      end

      it "サウナ投稿の情報が表示されていることを確認" do
        Post.take(5).each do |post|
          expect(page).to have_css ".show-post"
          expect(page).to have_link "もっとみる"
          expect(page).to have_link "編集"
          expect(page).to have_link "削除"
        end
      end

      it "サウナ投稿のページネーションが表示されていることを確認" do
        expect(page).to have_css ".pagination"
      end
    end
  end

  describe "プロフィール登録ページ" do
    before do
      sign_in @user
      visit edit_user_path(@user)
    end

    context "ページレイアウト" do
      it "自己紹介が表示されることを確認" do
        expect(page).to have_css ".form-group"
      end
    end
  end
end
