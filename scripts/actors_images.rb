require "open-uri"

Actor.all.each do |a|
  puts a.screen_name
  begin
    open("http://res.cloudinary.com/demo/image/twitter_name/w_300/#{a.screen_name}.jpg"){|f|
      File.open("scripts/actor_images/#{a.screen_name}.jpg","wb") do |file|
      file.puts f.read
      end
    }
  rescue
      puts "#{a.screen_name} ya NO existe"
  end
end