class CreateAddColumns < ActiveRecord::Migration
  def change
    add_column :retweets, :tweet_id, :integer, references: :tweets
    add_index :retweets, :tweet_id
  end
end
