require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#create' do
    before do
      @room = FactoryBot.build(:room)
    end

    it "nameの値があると保存できる" do
      expect(@room).to be_valid
      #expectとは直訳で「期待する」という意味
      #@roomの中がbe_valid(保存)されることを期待する
    end

    it "nameの値が無いとできない" do
      @room.name = nil
      @room.valid?
      expect(@room.errors.full_messages).to include("Name can't be blank")
    end
  end

end