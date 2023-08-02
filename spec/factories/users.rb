FactoryBot.define do
  factory :user do
    transient do
      test_user {Gimei.name}
    end
    nickname {Faker::Name.initials(number: 3)}
    email {Faker::Internet.email}
    password {Faker::Lorem.characters(number: (6..128), min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}
    last_name {test_user.last.kanji}
    first_name {test_user.first.kanji}
    last_name_kana {test_user.last.katakana}
    first_name_kana {test_user.first.katakana}
    birth_date {Faker::Date.between(from: '1930-01-01', to: '2018-12-31')}
  end
end
