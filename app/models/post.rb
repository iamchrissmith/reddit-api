require 'date'
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
    @created = attrs['created']
    @url = attrs['url']
    @num_comments = attrs['num_comments']
    @score = attrs['score']
  end

  private
    attr_reader :attrs
    
end
