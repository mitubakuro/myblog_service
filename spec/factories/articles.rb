FactoryBot.define do
  factory :article do
    title {"ファクトリーボット"}
    body {"ファクトリーボットから投稿"}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/akusyu_uchuujin.png'), filename: ' akusyu_uchuujin.png')
    end
  end
end