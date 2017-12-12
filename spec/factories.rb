require 'faker'

FactoryGirl.define do
  factory :portfolio_header do
    portfolio nil
    header_one "MyString"
    header_two "MyString"
    cover_image "MyString"
    avatar_image "MyString"
  end
  factory :technology do
    name "MyString"
    portfolio nil
    years_exp 1
    proficiency 1
    show_years_exp false
    show_proficiency false
  end
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    # confirmed_at Date.today
  end
end
