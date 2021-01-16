require 'rails_helper'

RSpec.describe "サウナ施設新規作成", type: :request do
  before do
    @user = create(:user)
    @post = create(:post, user: @user)
    @image_path = File.join(Rails.root, 'spec/fixtures/test-post.jpeg')
    @image = Rack::Test::UploadedFile.new(@image_path)
  end

  context "ログイン済みユーザーの場合" do
    before do
      sign_in @user
      get new_post_path
    end

    it "レスポンスが正常に表示されるまで" do
      expect(response).to have_http_status "200"
      expect(response).to render_template('posts/new')
    end

    it "有効な施設データで登録できること" do
      expect {
        post posts_path, params: { post: { title: "スカイスパYOKOHAMA",
                                           description: "サ室は静かで、水風呂と外気浴との導線が完璧。整いイスが多いのも最高です。",
                                           address: "神奈川県横浜市西区高島２丁目１９−１２",
                                           site_url: "https://www.skyspa.co.jp",
                                           rate: 5,
                                           infection_control_rate: 5,
                                           image: @image } }
      }.to change(Post, :count).by(1)
      follow_redirect!
      expect(response).to render_template('posts/show')
    end

    it "無効な施設データで登録できないこと" do
      expect {
        post posts_path, params: { post: { title: "",
                                           description: "サ室は静かで、水風呂と外気浴との導線が完璧。整いイスが多いのも最高です。",
                                           address: "神奈川県横浜市西区高島２丁目１９−１２",
                                           site_url: "https://www.skyspa.co.jp",
                                           rate: 5,
                                           infection_control_rate: 5,
                                           image: @image } }
      }.to change(Post, :count).by(0)
      expect(response).to render_template('posts/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトされること" do
      get new_post_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end
  end
end
