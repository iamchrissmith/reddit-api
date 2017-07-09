class SubredditsController < ApplicationController
  def show
    subreddit_name = params['subreddit']
    @subreddit = Subreddit.new(current_user.subreddit_details(subreddit_name)['data'])
    @subreddit_posts = @subreddit.get_hot_posts(access_token: current_user.access_token, subreddit: subreddit_name)
    # binding.pry
  end
end
