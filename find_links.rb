
require "rubygems"
require "twitter"
require 'extract_urls'
include PrintAraay
@extract_url=ExtractUrl.new

if ARGV[0].nil?
  puts "Please enter hashtag with filename."
  puts "Example:- ruby find_link.rb a_hashtag"
else
  unless ARGV[1].nil?
    puts "you have entered more than one hash tag."
    puts "showing results for first hashtag only"
  end
  arg=ARGV[0]
  result=@extract_url.fetch_tweets_by_hashtag(arg,100)
  urls=@extract_url.find_links_by_tweets(result)
  print_array(urls)
end
