class AddActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name
      t.string :screen_name, index: true, unique: true
      t.integer :nature, default: 0
      t.integer :relevant_year
    end

    create_table :mentions do |t|
      t.string :mention_date
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
      t.string :user_screen_name
      t.string :user_time_zone
      t.references :actor, index:true
    end
  end
end
