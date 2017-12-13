require 'faker'

FactoryGirl.define do
  factory :about do
    portfolio nil
    about_me "MyText"
    location "MyString"
    about_me_brief "MyString"
  end
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
  factory :portfolio do
    url "myUrl"
    color_one '#ffffff'
    color_two '#ffffff'
    color_three '#ffffff'
    color_four '#ffffff'
    user 1
    id 1
  end
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    # confirmed_at Date.today
  end
end
