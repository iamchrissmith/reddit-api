FactoryGirl.define do
  factory :user do
    uid "egvzrs"
    name "_iamchrissmith"
    access_token ENV["USER_ACCESS_TOKEN"]
    refresh_token ENV["USER_REFRESH_TOKEN"]
  end
end
