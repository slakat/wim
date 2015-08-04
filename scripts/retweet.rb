Actor.all.each do |a|
   @mentions=a.mentions.where('LOWER(text) LIKE ?', "%#{a.real_username}:%".downcase)
   puts "======init #{a.screen_name} #{@mentions.count}========="
   @mentions.each_with_index do |r, index|
      date = r.mention_date.to_datetime
      Retweet.create!(actor_id: a.id,mention_id: r.id, text: r.text, user_screen_name: r.user_screen_name, rt_date: date)
   end

   puts "=========READY #{a.screen_name}========="
end