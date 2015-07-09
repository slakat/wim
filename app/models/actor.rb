class Actor < ActiveRecord::Base
  has_many :mentions
  has_many :retweets
  has_many :tweets
  has_many :ranking_tweets
  has_many :protests


end
