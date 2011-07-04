
require "rubygems"
begin
  require "twitter"
rescue LoadError
  puts "twitter gem is not install in your system."
  puts "command for installing gem: gem install twitter"
end
require 'extract_urls'
include PrintAraay
@extract_url=ExtractUrl.new

if ARGV[0].nil?
  puts "Please enter hashtag with filename."
  puts "Example:- ruby find_link.rb a_hashtag"
elsif !ARGV[1].nil?
  puts "you have entered more than one hash tag."
  puts "showing results for first hashtag only"
  arg=ARGV[0]
  result=@extract_url.find_tweets_by_hashtag(arg,10)
  urls=@extract_url.find_links_by_tweets(result)
  print_array(urls)
else
  arg=ARGV[0]
  result=@extract_url.find_tweets_by_hashtag(arg,10)
  urls=@extract_url.find_links_by_tweets(result)
  print_array(urls)
end




