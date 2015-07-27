class ActorsController < ApplicationController
	helper_method :sort_column, :sort_direction
  def index
  	 @ids = Retweet.all.group('actor_id').order('count_actor_id DESC').limit(15).count('actor_id')
  	 @actors= @ids.keys
  	 @tweets = RankingTweet.order('retweets DESC').limit(300).paginate(:per_page => per_page, :page => params[:page])
  end

  def show
    @actor = Actor.find(params[:id])
    number=@actor.tweets.where('text NOT LIKE ?', "%RT @%").count
    @total_tweets = @actor.tweets.count
    @original = ((number).fdiv(@total_tweets)*100).round(1)
    @total_mentions = @actor.mentions.count
    @total_rt= @actor.retweets.count
    @mentions = ((@total_mentions- @total_rt).fdiv(@total_mentions)*100).round(1)
    @dates = ["2011-05-12".to_date,"2011-05-26".to_date,"2011-06-01".to_date,"2011-06-16".to_date,"2011-06-23".to_date,"2011-06-30".to_date,"2011-07-14".to_date,"2011-08-04".to_date,"2011-08-18".to_date,"2011-08-24".to_date,"2011-09-22".to_date,"2011-09-29".to_date,"2011-10-18".to_date,"2012-04-25".to_date,"2012-05-16".to_date,"2012-08-08".to_date,"2012-08-28".to_date,"2012-09-27".to_date,"2013-04-11".to_date,"2013-05-08".to_date,"2013-05-28".to_date,"2013-06-13".to_date,"2013-06-26".to_date,"2013-07-11".to_date,"2013-09-05".to_date,"2013-10-17".to_date]
    @rt_by = @actor.retweets.group('user_screen_name').order('count_user_screen_name DESC').limit(5).count('user_screen_name')
    @keys= @rt_by.keys
    @my_rt = @actor.tweets.group('in_reply_to_screen_name').order('count_in_reply_to_screen_name DESC').limit(5).count('in_reply_to_screen_name')
    @my_keys= @my_rt.keys
  end

   def sort_column
    Retweet.has_column_text?(params[:sort]) ? params[:sort] : :text
  end

  def per_page
    params[:page_limit] || 10
  end
end
