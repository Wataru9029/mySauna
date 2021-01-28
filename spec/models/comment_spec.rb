require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = build(:comment)
  end

  context 'バリデーション' do
    it '有効な状態であること' do
      expect(@comment).to be_valid
    end

    it 'user_idが存在しなければ無効な状態であること' do
      @comment.user_id = nil
      expect(@comment).not_to be_valid
    end

    it 'post_idが存在しなければ無効な状態であること' do
      @comment.post_id = nil
      expect(@comment).not_to be_valid
    end

    it '内容が存在しなければ無効な状態であること' do
      @comment.content = nil
      expect(@comment).not_to be_valid
    end

    it '内容が200文字以内であること' do
      @comment.content = 'a' * 201
      expect(@comment).not_to be_valid
    end
  end
end
