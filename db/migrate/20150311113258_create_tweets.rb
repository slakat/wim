class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_date
      t.boolean :favorited
      t.string :in_reply_to_screen_name
      t.string :permanent_link
      t.string :lang
      t.string :source
      t.text :text
      t.text :user_profile_description
      t.string :user_profile_location
      t.string :user_date
      t.integer :user_followers_count
      t.string :user_name
      t.string :user_screen_name, index: true
      t.string :user_time_zone
      t.references :actor, index:true
    end
  end
end
