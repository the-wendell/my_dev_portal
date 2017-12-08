require 'faker'

FactoryGirl.define do
  factory :project do
    references ""
    titl "MyString"
    link "MyString"
    descrption "MyText"
    image "MyString"
    tech "MyText"
    role "MyString"
  end
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    # confirmed_at Date.today
  end
end
