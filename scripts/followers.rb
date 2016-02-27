#universidad de chile - @la_fech
#2011 - @camila_vallejo
#2012 - @gabrielboric
#2013 - @AFielbaum

#UC - @feuc
#2011 - @GiorgioJackson
#2012 - @NoamTitelman
#2013 - @velagrau

fech = Actor.find_by_screen_name("@la_fech".downcase)
camila = Actor.find_by_screen_name( "@camila_vallejo".downcase)
gabriel = Actor.find_by_screen_name( "@gabrielboric".downcase)
andres = Actor.find_by_screen_name( "@AFielbaum".downcase)

feuc = Actor.find_by_screen_name( "@feuc".downcase)
giorgio = Actor.find_by_screen_name( "@GiorgioJackson".downcase)
noam = Actor.find_by_screen_name( "@NoamTitelman".downcase)
diego = Actor.find_by_screen_name( "@velagrau".downcase)

actors = [fech,camila,gabriel,andres,feuc,giorgio,noam,diego]
months = ["Jan", "Feb", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov","Dec"]
y = 2013

actors.each do |f|

puts f.screen_name
 months.each do |m|
   puts m
   t = f.tweets.where("tweet_date LIKE '%#{y}%' AND tweet_date LIKE '%#{m}%'").first
   unless t.nil?
     puts t.user_followers_count
   end
 end
end