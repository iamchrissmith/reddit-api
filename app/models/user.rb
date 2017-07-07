class User < ApplicationRecord
  def renew_token
    self.access_token = RedditService.renew_access_token(refresh_token)
    self.save
  end

  def karma
    RedditService.get_user_karma(access_token)
  end

  def subreddit_subscriptions
    RedditService.get_user_subscriptions(access_token).map do |raw_subreddit|
      Subreddit.new(raw_subreddit)
    end
  end
end
