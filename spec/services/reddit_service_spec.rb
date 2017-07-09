require 'rails_helper'

describe RedditService do
  let(:user) { create(:user) }
  context 'self.get_user' do
    it 'returns a valid array of hashes for the user' do
      VCR.use_cassette('redditservice.get_user') do
        raw_user = RedditService.get_user(user.access_token)

        expect(raw_user).to be_a Hash
        expect(raw_user).to have_key('id')
        expect(raw_user['id']).to be_a String
        expect(raw_user).to have_key('name')
        expect(raw_user['name']).to be_a String
        expect(raw_user).to have_key('link_karma')
        expect(raw_user['link_karma']).to be_an Integer
        expect(raw_user).to have_key('comment_karma')
        expect(raw_user['comment_karma']).to be_an Integer
      end
    end
  end

  context 'self.get_user_karma' do
    it 'returns a valid array of hashes for the user karma' do
      VCR.use_cassette('redditservice.get_user_karma') do
        raw_user_karma = RedditService.get_user_karma(user.access_token)

        expect(raw_user_karma).to be_a Hash
        expect(raw_user_karma).to have_key(:post)
        expect(raw_user_karma[:post]).to be_a Integer
        expect(raw_user_karma).to have_key(:comment)
        expect(raw_user_karma[:comment]).to be_a Integer
      end
    end
  end

  context 'self.get_user_subscriptions' do
    it 'returns a valid array of hashes for the user reddit subscriptions' do
      VCR.use_cassette('redditservice.get_user_subscriptions') do
        raw_user_subscriptions = RedditService.get_user_subscriptions(user.access_token)
        raw_user_subscription = raw_user_subscriptions.first

        expect(raw_user_subscriptions).to be_an Array
        expect(raw_user_subscriptions.count).to eq(3)
        expect(raw_user_subscription).to have_key('data')
        expect(raw_user_subscription['data']).to be_a Hash
        expect(raw_user_subscription['data']).to have_key('display_name_prefixed')
        expect(raw_user_subscription['data']['display_name_prefixed']).to be_a String
        expect(raw_user_subscription['data']).to have_key('title')
        expect(raw_user_subscription['data']['title']).to be_a String
        expect(raw_user_subscription['data']).to have_key('url')
        expect(raw_user_subscription['data']['url']).to be_a String
        expect(raw_user_subscription['data']).to have_key('public_description')
        expect(raw_user_subscription['data']['public_description']).to be_a String
        expect(raw_user_subscription['data']).to have_key('subscribers')
        expect(raw_user_subscription['data']['subscribers']).to be_an Integer
        expect(raw_user_subscription['data']).to have_key('created_utc')
        expect(raw_user_subscription['data']['created_utc']).to be_a Float
      end
    end
  end

  context 'self.get_subreddit_details' do
    it 'returns a valid array of hashes for the reddit details' do
      VCR.use_cassette('redditservice.get_subreddit_details') do
        raw_subreddit = RedditService.get_subreddit_details(access_token: user.access_token, subreddit: 'programming')
        binding.pry

        expect(raw_user_subscriptions).to be_a Hash
        expect(raw_user_subscription).to have_key('data')
        expect(raw_user_subscription['data']).to be_a Hash
        expect(raw_user_subscription['data']).to have_key('display_name_prefixed')
      end
    end
  end
end
