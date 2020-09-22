FactoryBot.define do
  factory :article do
    association :user
    title {"ファクトリーボット"}
    body {"ファクトリーボットから投稿"}
    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/office-1209640_1920.jpg'), filename: 'test.jpg', content_type: 'image/jpg')
    end
  end
end