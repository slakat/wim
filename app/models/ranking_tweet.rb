class RankingTweet < ActiveRecord::Base
  belongs_to :actor

  def self.link(user,key)
    #Retweet.find_by_text(key).mention.permanent_link
    k = key.partition(': ').last[0...-4]
    puts k
    t = Actor.find(user).tweets.where("text LIKE '%#{k}%'").first
    unless t
      t =Actor.find(user).retweets.find_by_text(key).mention
    end
    return t
  end

end
