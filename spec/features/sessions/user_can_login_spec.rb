require 'rails_helper'

describe "User wants to login with " do
  before {
    stub_omniauth
  }
  scenario "they click login and see their name" do

  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:reddit] = OmniAuth::AuthHash.new({
          provider: 'reddit',
          # uid: "1234",
          # extra: {
          #   raw_info: {
          #     name: "Horace",
          #     screen_name: "worace"
          #   }
          # },
          # credentials: {
          #   token: "pizza",
          #   secret: "secretpizza"
          # }
        })
  end
end
