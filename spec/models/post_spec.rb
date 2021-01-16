require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = build(:post)
  end

  context "バリデーション" do
    it "有効な状態であること" do
      expect(@post).to be_valid
    end

    it "施設名が存在しなければ無効な状態であること" do
      @post.title = nil
      @post.valid?
      expect(@post.errors[:title]).to include("を入力してください")
    end

    it "施設名が50文字以内であること" do
      @post.title = "a" * 51
      @post.valid?
      expect(@post.errors[:title]).to include("は50文字以内で入力してください")
    end

    it "施設説明が1200文字以内であること" do
      @post.description = "a" * 1201
      @post.valid?
      expect(@post.errors[:description]).to include("は1200文字以内で入力してください")
    end

    it "ユーザーIDが存在しなければ無効な状態であること" do
      @post.user_id = nil
      @post.valid?
      expect(@post.errors[:user_id]).to include("を入力してください")
    end

    it "おすすめ度が1以上でなければ無効な状態であること" do
      @post.rate = 0
      @post.valid?
      expect(@post.errors[:rate]).to include("は1以上の値にしてください")
    end

    it "おすすめ度が5以下でなければ無効な状態であること" do
      @post.rate = 6
      @post.valid?
      expect(@post.errors[:rate]).to include("は5以下の値にしてください")
    end

    it "感染対策度が1以上でなければ無効な状態であること" do
      @post.infection_control_rate = 0
      @post.valid?
      expect(@post.errors[:infection_control_rate]).to include("は1以上の値にしてください")
    end

    it "感染対策度が5以下でなければ無効な状態であること" do
      @post.infection_control_rate = 6
      @post.valid?
      expect(@post.errors[:infection_control_rate]).to include("は5以下の値にしてください")
    end
  end
end
