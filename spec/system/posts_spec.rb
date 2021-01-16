require 'rails_helper'

RSpec.describe "Posts", type: :system do
  before do
    @user = create(:user)
    @other_user = create(:user)
    @post = create(:post, user: @user)
    @comment = create(:comment, user_id: @user.id, post: @post)
  end

  describe "サウナ施設登録ページ" do
    before do
      sign_in @user
      visit new_post_path
    end

    context "サウナ施設登録処理" do
      it "有効な情報でサウナ施設登録を行うとサウナ施設詳細ページに飛ぶこと" do
        fill_in "施設名", with: "スカイスパYOKOHAMA"
        attach_file "post[image]", "#{Rails.root}/spec/fixtures/test-post.jpeg"
        fill_in "所在地", with: "神奈川県横浜市西区高島２丁目１９−１２"
        fill_in "施設説明", with: "サ室は静かで、水風呂と外気浴との導線が完璧。整いイスが多いのも最高です。"
        fill_in "参考URL", with: "https://www.skyspa.co.jp"
        fill_in "おすすめ度", with: 5
        fill_in "感染対策度", with: 4
        click_button "登録"
      end
    end
  end

  describe "サウナ施設詳細ページ" do
    context "ページレイアウト" do
      before do
        sign_in @user
        visit post_path(@post)
      end

      it "編集と削除が表示されていることを確認" do
        expect(page).to have_link '編集', href: edit_post_path(@post)
        expect(page).to have_link '削除', href: post_path(@post)
      end
    end
  end

  describe "サウナ施設編集ページ" do
    before do
      sign_in @user
      visit edit_post_path(@post)
    end

    context "サウナ施設の更新処理" do
      it "有効な情報で更新できること" do
        fill_in "施設名", with: "カプセルホテル北欧"
        attach_file "post[image]", "#{Rails.root}/spec/fixtures/test-post2.jpeg"
        fill_in "施設説明", with: "ドラマ「サ道」のロケ地として有名です。"
        click_button "編集"
        expect(@post.reload.image.url).to include "test-post2.jpeg"
      end
    end

    context "コメントの登録処理・削除" do
      it "自分のサウナ施設に対するコメントの登録・削除が正常に行えること" do
        sign_in @user
        visit post_path(@post)
        fill_in "comment[content]", with: "いいね！"
        click_button "コメントする"
        expect(page).to have_selector 'span', text: "いいね！"
        click_link "削除", href: post_comment_path(@post, Comment.last)
        expect(page).not_to have_selector 'span', text: "いいね！"
      end

      it "別ユーザーのサウナ施設には削除リンクがないこと" do
        sign_in @other_user
        visit post_path(@post)
        within find("#comment-#{@comment.id}") do
          expect(page).to have_selector 'span', text: @comment.content
          expect(page).not_to have_link '削除', href: post_comment_path(@post, Comment.first)
        end
      end
    end
  end

  describe "検索機能" do
    it "常に検索フォームが表示されていることを確認" do
        visit root_path
        expect(page).to have_css 'form#post-search'
    end
  end

  describe "ランキングページ" do
    it "正常に人気サウナが表示されていること" do
        visit rank_path
        expect(page).to have_selector 'h3.rank-posts', text: "♨︎ 人気サウナ10選 ♨︎"
    end

    it "正常に高評価サウナが表示されていること" do
        visit rate_path
        expect(page).to have_selector 'h3.rate-posts', text: "♨︎ おすすめ度の高いサウナ ♨︎"
    end

    it "正常に衛生的サウナが表示されていること" do
        visit infection_control_path
        expect(page).to have_selector 'h3.infection-control-posts', text: "♨︎ 感染対策度の高いサウナ ♨︎"
    end
  end
end
