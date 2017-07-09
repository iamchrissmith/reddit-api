require 'rails_helper'

RSpec.feature "Users wants to view profile" do
  context "when not logged in" do
    scenario "they do not see a link to their profile" do
      visit root_path
      expect(page).to have_content "Sign in to Reddit"
      expect(page).not_to have_link "Logout", href: logout_path
    end
  end
  
  context "when logged in" do
    let(:user) { create(:user) }
    let(:profile_json) { fixture('me.json') }
    let(:subreddit_json) { fixture('subreddit_subscriptions.json') }

    scenario "they see their profile" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:expiry).and_return(DateTime.now + 10.minutes)

      allow_any_instance_of(RedditService).to receive(:get_user).and_return(profile_json)
      allow_any_instance_of(RedditService).to receive(:get_user_subscriptions).and_return(subreddit_json)


      visit root_path

      expect(page).not_to have_content "Sign in to Reddit"
      expect(page).to have_link user.name, href: user_path(user)
      expect(page).to have_link "Logout", href: logout_path

      click_on user.name

      expect(page).to have_content "10 Post Karma"
      expect(page).to have_content "my subreddits"
    end
  end
end
