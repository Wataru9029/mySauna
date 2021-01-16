require 'rails_helper'

RSpec.describe "サウナ施設編集ページ", type: :request do
  before do
    @user = create(:user)
    @other_user = create(:user)
    @post = create(:post, user: @user)
    @image_path = File.join(Rails.root, 'spec/fixtures/test-post2.jpeg')
    @image = Rack::Test::UploadedFile.new(@image_path)
  end

  context "認可されたユーザーの場合" do
    it "有効な施設データで編集できること" do
      sign_in @user
      get edit_post_path(@post)
      patch post_path, params: { post: { title: "サウナ&カプセルホテル北欧",
                                         address: "東京都台東区上野７丁目２−１６",
                                         description: "ドラマ「サ道」のロケ地として有名です。",
                                         site_url: "https://www.saunahokuou.com",
                                         rate: 5,
                                         infection_control_rate: 4,
                                         image: @image } }
      redirect_to @post
      follow_redirect!
      expect(response).to render_template('posts/show')
    end
  end

  context "別のアカウントユーザーの場合" do
    it "ホーム画面にリダイレクトされること" do
      sign_in @other_user
      get edit_post_path(@post)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_url
      patch post_path, params: { post: { title: "サウナ&カプセルホテル北欧",
                                         address: "東京都台東区上野７丁目２−１６",
                                         description: "ドラマ「サ道」のロケ地として有名です。",
                                         site_url: "https://www.saunahokuou.com",
                                         rate: 5,
                                         infection_control_rate: 4,
                                         image: @image} }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_url
    end
  end
end
