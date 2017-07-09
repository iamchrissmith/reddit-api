class Post
  attr_reader :title,
              :author,
              :domain,
              :created,
              :url,
              :num_comments,
              :score

  def initialize(attrs)
    @title = attrs['title']
    @author = attrs['author']
    @domain = attrs['domain']
    @created = time_since_created(attrs['created'])
    @url = attrs['url']
    @num_comments = attrs['num_comments']
    @score = attrs['score']
  end

  private
    attr_reader :attrs

    def time_since_created(timestamp)
      {
        year: DateTime.now.year - DateTime.strptime(timestamp.to_s, '%s').year,
        day: DateTime.now.day - DateTime.strptime(timestamp.to_s, '%s').day,
        hour: DateTime.now.hour - DateTime.strptime(timestamp.to_s, '%s').hour,
        minute: DateTime.now.minute - DateTime.strptime(timestamp.to_s, '%s').minute
      }
    end
end
