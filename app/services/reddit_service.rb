class RedditService
  def self.sign_in(code)
    tokens = get_tokens(code)
    raw_user = get_user(tokens["access_token"])

    user = User.find_or_create_by(uid: raw_user["id"])
    user.name = raw_user["name"]
    user.access_token = tokens["access_token"]
    user.refresh_token = tokens["refresh_token"]

    user
  end

  def self.renew_access_token(refresh_token)
    url = "https://www.reddit.com/api/v1/access_token"
    conn = Faraday.new(url)
    conn.basic_auth(ENV["REDDIT_KEY"],ENV["REDDIT_SECRET"])

    response = conn.post(
      url,
      grant_type: "refresh_token",
      refresh_token: refresh_token
    )

    JSON.parse(response.body)["access_token"]
  end

  def self.get_user_karma(access_token)
    url = "https://oauth.reddit.com/api/v1/me"
    conn = Faraday.new(url)
    conn.authorization('bearer', access_token)

    response = conn.get
    {
      post: JSON.parse(response.body)["link_karma"],
      comment: JSON.parse(response.body)["comment_karma"]
    }
  end

  def self.get_user_subscriptions(access_token)
    url = "https://oauth.reddit.com/subreddits/mine/subscriber"
    conn = Faraday.new(url)
    conn.authorization('bearer', access_token)

    response = conn.get
    JSON.parse(response.body)["data"]["children"]
  end

  private

    def self.get_user(token)
      url = "https://oauth.reddit.com/api/v1/me"
      conn = Faraday.new(url)
      conn.authorization('bearer', token)

      response = conn.get
      JSON.parse(response.body)
    end

    def self.get_tokens(code)
      url = "https://www.reddit.com/api/v1/access_token"
      conn = Faraday.new(url)
      conn.basic_auth(ENV["REDDIT_KEY"],ENV["REDDIT_SECRET"])

      response = conn.post(
        url,
        code: code,
        redirect_uri: ENV["REDDIT_REDIRECT"],
        grant_type: "authorization_code"
      )

      JSON.parse(response.body)
    end
end

# url = "https://oauth.reddit.com/api/v1/me/karma" # subreddit karma breakdown

# GET /r/subreddit/about - read
# Return information about the subreddit.
# Data includes the subscriber count, description, and header image.

# GET /r/subreddit/about/rules - read
# Get the rules for the current subreddit

# GET [/r/subreddit]/sidebar - read
# Get the sidebar for the current subreddit
