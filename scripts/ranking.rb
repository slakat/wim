Actor.all.each do |a|

  @table = a.retweets.group('text').order('count_text DESC').count('text')
  #@keys= @table.keys.paginate(:per_page => per_page, :page => params[:page])
  #@mentions = @keys

  @keys= @table.keys
  @keys.each_with_index do |key,index|
    k = key.partition(': ').last[0...-4]
    puts k

    t = a.tweets.where(["LOWER(text) LIKE ?", "%#{k.gsub("'", "''")}%".downcase]).first
    if t
      tDate = t.tweet_date
    end
    unless t
      t =a.retweets.find_by_text(key).mention
      tDate = t.mention_date
    end

    RankingTweet.create!(actor_id: a.id,tweet_date: tDate,favorited: t.favorited, in_reply_to_screen_name: t.in_reply_to_screen_name,permanent_link: t.permanent_link,lang: t.lang,source: t.source, text: t.text,user_profile_description: t.user_profile_description,user_profile_location: t.user_profile_location,user_date: t.user_date, user_followers_count: t.user_followers_count,user_name: t.user_name, user_screen_name: t.user_screen_name,user_time_zone: t.user_time_zone, retweets: @table[key].to_s)

    puts index

    unless index<501
      break
    end
  end
end
puts '=========READY==========='
