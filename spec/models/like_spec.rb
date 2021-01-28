require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = build(:like)
  end

  it '有効であること' do
    expect(@like).to be_valid
  end

  it 'user_idが存在しなければ無効であること' do
    @like.user_id = nil
    expect(@like).not_to be_valid
  end

  it 'post_idが存在しなければ無効であること' do
    @like.post_id = nil
    expect(@like).not_to be_valid
  end
end
