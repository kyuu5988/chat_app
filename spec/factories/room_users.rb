FactoryBot.define do
  factory :room_user do
    association :user
    association :room
    #上により他のインスタンスも生成
  end
end