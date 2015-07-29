require 'smarter_csv'


Dir.foreach('tmp/test/tweets/') do |item|
  next if item == '.' or item == '..' or item[0]=='.'
  # without using chunks:
  filename = 'tmp/test/tweets/'+item

  actor_s = item.split('.')[0].split(' ')[1].downcase
  puts filename
  puts actor_s
  actor = Actor.where("LOWER(actors.screen_name) LIKE :actor_part", {:actor_part => "@#{actor_s.downcase}%"}).first
  options = {:key_mapping =>{ :favorited => :favorited, :in_reply_to_screen_name => :in_reply_to_screen_name, :permanent_link => :permanent_link, :lang => :lang, :source => :source, :text => :text, :user_profile_description => :user_profile_description, :user_profile_location => :user_profile_location, :user_created_at=> :user_date, :user_followers_count => :user_followers_count, :user_name => :user_name, :user_screen_name => :user_screen_name,:user_time_zone => :user_time_zone,:created_at => :tweet_date}, :remove_unmapped_keys => true, :verbose => false }
  unless actor.nil?
    puts actor.screen_name
    n = SmarterCSV.process(filename, options) do |array|
      # we're passing a block in, to process each resulting hash / =row (the block takes array of hashes)
      # when chunking is not enabled, there is only one hash in each array
      array.first.merge!(:actor_id => actor.id)
      puts array.first[:text]
      text = array.first[:text].to_s.force_encoding('UTF-8')
      array.first[:text] = text
      Tweet.create!( array.first )
    end
  end

end
