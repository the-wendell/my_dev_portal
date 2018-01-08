require 'faker'

FactoryGirl.define do
  factory :job_application do
    first_contact_date "2017-12-26"
    company_name "MyString"
    company_website "MyString"
    job_location "MyString"
    enthusiasm "MyString"
    job_title "MyString"
    job_link "MyString"
    referral "MyString"
    referral_type "MyString"
    status "MyString"
    industry "MyString"
    notes "MyText"
  end
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
    url "myurl"
    color_one '#ffffff'
    color_two '#ffffff'
    color_three '#ffffff'
    color_four '#ffffff'
    font_color_one '#ffffff'
    font_color_two '#ffffff'
    theme 'default'
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
