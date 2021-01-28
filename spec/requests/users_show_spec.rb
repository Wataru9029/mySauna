require 'rails_helper'

RSpec.describe 'プロフィールページ', type: :request do
  before do
    @user = create(:user)
  end

  context 'トップページ' do
    it 'レスポンスが正常に表示されること' do
      sign_in @user
      get user_path(@user)
      expect(response).to render_template('users/show')
    end
  end
end
