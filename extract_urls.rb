# To change this template, choose Tools | Templates
# and open the template in the editor.
class ExtractUrl
  def find_tweets_by_hashtag(arg,cnt)
    search = Twitter::Search.new
    tweets=search.hashtag(arg).result_type('recent').per_page(cnt).fetch
    tweets
  end

  def find_links_by_tweets(tweets)
    @urls=[]
    for tweet in tweets
      url=URI.extract(tweet.text)
      url.each do |str|
        @urls << str if str.start_with?("http"||"https")
      end if !url.nil? and !url.empty?
    end
    @urls=@urls.uniq
  end
end

module PrintAraay
  def print_array(array)
    if array.empty?
      puts "no content found."
    else
      array.each_with_index { |str, index|
        puts "#{index+1}. "+ str
      }
    end
  end
end
