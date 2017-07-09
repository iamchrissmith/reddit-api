class Subreddit
  attr_reader :name,
              :title,
              :url,
              :public_description,
              :description_html,
              :subscribers,
              :active_users,
              :created

  def initialize(attrs)
    @name = attrs["display_name_prefixed"]
    @title = attrs["title"]
    @url = attrs["url"]
    @public_description = attrs["public_description"]
    @description_html = attrs["description_html"]
    @subscribers = attrs["subscribers"]
    @active_users = attrs["active_user_count"]
    @created = years_since_created(attrs["created_utc"])
  end

  def get_hot_posts(attrs)
    RedditService.get_hot_posts(attrs)['data']['children'].map do |raw_post|
      Post.new(raw_post['data'])
    end
  end

  private
    attr_reader :attrs

    def years_since_created(timestamp)
      Date.today.year - DateTime.strptime(timestamp.to_s, '%s').year
    end
end
