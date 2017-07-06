class SessionsController < ApplicationController
  def create
    post_url = "https://www.reddit.com/api/v1/access_token"
    conn = Faraday.new(post_url)
    conn.basic_auth(ENV["REDDIT_KEY"],ENV["REDDIT_SECRET"])
    @response = conn.post(
      post_url,
      code: params["code"],
      redirect_uri: ENV["REDDIT_REDIRECT"],
      grant_type: "authorization_code"
    )

    response_body = JSON.parse(@response.body)
    token = response_body["access_token"]
    me_url = "https://oauth.reddit.com/api/v1/me"
    me_conn = Faraday.new(me_url)
    me_conn.authorization('bearer', token)
    response = me_conn.get
    auth = JSON.parse(response.body)
    user = User.find_or_create_by(uid: auth["id"])
    user.name = auth["name"]
    user.token = token
    user.karma = auth[""]
    if user.save
      session[:user_id] = user.id
    end

    redirect_to root_path
  end

  def destroy
    session.clear
    flash[:success] = 'Successfully logged out!'
    redirect_to root_path
  end
end
