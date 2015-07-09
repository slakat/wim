
DATES = ["2011-05-12".to_date,"2011-05-26".to_date,"2011-06-01".to_date,"2011-06-16".to_date,"2011-06-23".to_date,"2011-06-30".to_date,"2011-07-14".to_date,"2011-08-04".to_date,"2011-08-18".to_date,"2011-08-24".to_date,"2011-09-22".to_date,"2011-09-29".to_date,"2011-10-18".to_date,"2012-04-25".to_date,"2012-05-16".to_date,"2012-08-08".to_date,"2012-08-28".to_date,"2012-09-27".to_date,"2013-04-11".to_date,"2013-05-08".to_date,"2013-05-28".to_date,"2013-06-13".to_date,"2013-06-26".to_date,"2013-07-11".to_date,"2013-09-05".to_date,"2013-10-17".to_date]

DATES.each do |d|

  Actor.all.each do |a|

    @table = a.retweets.created_between(d-3.days,d+4.days)
    @table.each do |t|
      Protest.create!(to: a.real_username,from: t.user_screen_name, created_date: t.rt_date,protest: d, actor_id: a.id)
    end
  end
  puts d

end