class Subreddit
  attr_reader :name,
              :title,
              :url,
              :description,
              :subscribers,
              :created

  def initialize(attrs)
    @name = attrs["data"]["display_name_prefixed"]
    @title = attrs["data"]["title"]
    @url = attrs["data"]["url"]
    @description = attrs["data"]["public_description"]
    @subscribers = attrs["data"]["subscribers"]
    @created = years_since_created(attrs["data"]["created_utc"])
  end

  private
    attr_reader :attrs

    def years_since_created(timestamp)
      Date.today.year - DateTime.strptime(timestamp.to_s, '%s').year
    end
end
