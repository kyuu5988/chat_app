require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    before do
      @message = FactoryBot.build(:message)
      @message.image = fixture_file_upload('public/images/test_image.jpg')
    end

    it 'contentとimageがあれば保存可能' do
      expect(@message).to be_valid
    end

    it 'contentだけもで保存可能' do
      @message.image = nil
      expect(@message).to be_valid
    end

    it 'imageだけでも保存可能' do
      @message.content = nil
      expect(@message).to be_valid
    end

    it '全てが空だと保存出来ない' do
      @message.content = nil
      @message.image = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Content can't be blank")
    end
  end
end