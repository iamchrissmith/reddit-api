class RedditService
  def initialize(attrs)
    @access_token = attrs[:access_token]
    @subreddit = attrs[:subreddit]
    @conn = Faraday.new(url: "https://oauth.reddit.com")
    conn.authorization('bearer', access_token)
  end

  def self.get_user(access_token)
    new(access_token: access_token).get_user
  end

  def self.get_user_karma(access_token)
    response = new(access_token: access_token).get_user
    {
      post: response['link_karma'],
      comment: response['comment_karma']
    }
  end

  def self.get_user_subscriptions(access_token)
    new(access_token: access_token).get_user_subscriptions['data']['children']
  end

  def self.get_subreddit_details(attrs)
    new(attrs).get_subreddit_details
  end

  def self.get_hot_posts(attrs)
    new(attrs).get_hot_posts
  end

  def get_user
    response = conn.get '/api/v1/me'
    JSON.parse(response.body)
  end

  def get_user_subscriptions
    response = conn.get '/subreddits/mine/subscriber'
    JSON.parse(response.body)
  end

  def get_subreddit_details
    response = conn.get "/r/#{subreddit}/about"
    JSON.parse(response.body)
  end

  def get_hot_posts
    response = conn.get "/r/#{subreddit}"
    JSON.parse(response.body)
  end

  private
    attr_reader :conn, :access_token, :subreddit

end

# url = "https://oauth.reddit.com/api/v1/me/karma" # subreddit karma breakdown

# GET /r/subreddit/about - read
# Return information about the subreddit.
# Data includes the subscriber count, description, and header image.

# GET /r/subreddit/about/rules - read
# Get the rules for the current subreddit

# GET [/r/subreddit]/sidebar - read
# Get the sidebar for the current subreddit
