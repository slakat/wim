class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.references :actor, index:true
      t.references :mention
      t.text :text
      t.string :user_screen_name, index:true
      t.datetime :rt_date

    end
  end
end
