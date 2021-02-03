require 'rails_helper'

RSpec.describe Notification, type: :model do
  before do
    @notification = build(:notification)
  end

  it 'notificationインスタンスが有効であること' do
    expect(@notification).to be_valid
  end
end
