class Protests < ActiveRecord::Migration
  def change
    create_table :protests do |t|
      t.string :to, index: true
      t.string :from
      t.datetime :created_date
      t.date :protest, index: true
      t.references :actor
    end
  end
end
