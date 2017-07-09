class User < ApplicationRecord
  def renew_token
    self.access_token = RedditOauthService.renew_access_token(refresh_token)
    self.save
  end

  def karma
    RedditService.get_user_karma(access_token)
  end

  def subreddit_subscriptions
    RedditService.get_user_subscriptions(access_token).map do |raw_subreddit|
      Subreddit.new(raw_subreddit['data'])
    end
  end

  def subreddit_details(subreddit)
    RedditService.get_subreddit_details(access_token: access_token, subreddit: subreddit)
  end
end
