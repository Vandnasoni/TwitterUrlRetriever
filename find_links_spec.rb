# To change this template, choose Tools | Templates
# and open the template in the editor.

$LOAD_PATH.unshift File.dirname(__FILE__) + '/..'
require 'rubygems'
begin
  require "rspec"
rescue
  puts "rspec gem is not install in your system."
  puts "command for installing gem: gem install rspec"
end
begin
  require "twitter"
rescue
  puts "twitter gem is not install in your system."
  puts "command for installing gem: gem install twitter"
end
require File.dirname(__FILE__) + '/find_links.rb'


describe ExtractUrl do
  before(:each) do
    @extract_url = ExtractUrl.new
    @search = Twitter::Search.new
  end
  it "should contain hashtag and return an array" do
    @search.hashtag('ruby').query[:q].should include '#ruby'
    results=@extract_url.find_tweets_by_hashtag('ruby',5)
    results.count.should == 5
    results.class.should == Array
  end

  it "should fetch 5 recent tweets per page" do
    @search.result_type('recent').query[:result_type].should == 'recent'
    @search.per_page(5).query[:rpp].should == 5
  end

  it "should parse the given array to extract links and return array of unique links starting with http or https" do
    tweets=@extract_url.find_tweets_by_hashtag('ruby',5)
    urls=@extract_url.find_links_by_tweets(tweets)
    urls.class.should == Array
    urls.count.should == urls.uniq.count
    urls.each do |url|
      url.class.should == String
      url.start_with?("http" ||"https").should ==true
    end
  end
  

end


