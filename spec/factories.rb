FactoryGirl.define do
  factory :user do
    name 'Ryan McCombe'
    email 'ryanmccombe@gmail.com'
    password 'foobar'
    password_confirmation 'foobar'
  end
end