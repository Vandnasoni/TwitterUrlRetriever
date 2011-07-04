# To change this template, choose Tools | Templates
# and open the template in the editor.

$LOAD_PATH.unshift File.dirname(__FILE__) + '/..'
require 'rubygems'
require "rspec"
require "twitter"
require File.dirname(__FILE__) + '/extract_urls.rb'


describe "ExtractUrl" do

  before(:each) do
    @extract_url = ExtractUrl.new
    @search = Twitter::Search.new
  end
  it "should contain hashtag and return an array" do
    @search.hashtag('ruby').query[:q].should include '#ruby'
    results=@extract_url.fetch_tweets_by_hashtag('ruby',5)
    results.count.should == 5
    results.class.should == Array
  end

  it "should fetch 5 recent tweets per page" do
    @search.result_type('recent').query[:result_type].should == 'recent'
    @search.per_page(5).query[:rpp].should == 5
  end

  it "should parse the given array to extract links and return array of unique links starting with http or https" do
    tweets=@extract_url.fetch_tweets_by_hashtag('ruby',5)
    urls=@extract_url.find_links_by_tweets(tweets)
    urls.class.should == Array
    urls.count.should == urls.uniq.count
    urls.each do |url|
      url.class.should == String
      url.start_with?("http" ||"https").should ==true
    end
  end
end

describe "Print Array" do
  include PrintAraay

  it "should print msg when array is empty" do
    array=[]
    print_array(array)
    $stdout.received_message?("no content found.")
  
  end
end
