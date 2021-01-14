require 'rails_helper'

RSpec.describe "静的ページ", type: :request do
  context "トップページ" do
    it "レスポンスが正常に表示されること" do
        get root_path
        expect(response).to be_success
        expect(response).to have_http_status "200"
    end
  end
end
