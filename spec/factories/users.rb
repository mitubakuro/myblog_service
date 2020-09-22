FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    firstname {"ファクトリー"}
    lastname {"ボット"}
    birthday {"2012-12-12"}
    password = Faker::Internet.password(min_length: 8)
    password {password}
    password_confirmation {password}
  end
end