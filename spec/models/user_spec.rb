require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
    @other_user = create(:user)
  end

  context "フォロー機能" do
    it "フォローとフォロー解除が正常に機能すること" do
      expect(@user.following?(@other_user)).to be_falsey
      @user.follow(@other_user)
      expect(@user.following?(@other_user)).to be_truthy
      @user.unfollow(@other_user)
      expect(@user.following?(@other_user)).to be_falsey
    end
  end
end
