class RedditOauthService
  def initialize(code)
    @code = code
    @conn = Faraday.new(url: "https://www.reddit.com/api/v1/access_token")
  end

  def self.sign_in(code)
    new(code).sign_in
  end

  def self.renew_access_token(refresh_token)
    new(refresh_token).refresh_token
  end

  def sign_in
    tokens = get_tokens
    raw_user = RedditService.get_user(tokens["access_token"])

    build_user(raw_user, tokens)
  end

  def refresh_token
    conn.basic_auth(ENV["REDDIT_KEY"],ENV["REDDIT_SECRET"])

    response = conn.post do |req|
      req.body = {
        grant_type: "refresh_token",
        refresh_token: code
      }
    end

    JSON.parse(response.body)["access_token"]
  end

  private
    attr_reader :code, :conn

    def get_tokens
      conn.basic_auth(ENV["REDDIT_KEY"],ENV["REDDIT_SECRET"])

      response = conn.post do |req|
        req.body = {
          code: code,
          redirect_uri: ENV["REDDIT_REDIRECT"],
          grant_type: "authorization_code"
        }
      end

      JSON.parse(response.body)
    end

    def build_user(raw_user, tokens)
      user               = User.find_or_create_by(uid: raw_user["id"])
      user.name          = raw_user["name"]
      user.access_token  = tokens["access_token"]
      user.refresh_token = tokens["refresh_token"]
      user
    end
end
