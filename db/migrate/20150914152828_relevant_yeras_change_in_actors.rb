class RelevantYerasChangeInActors < ActiveRecord::Migration
  def change
    change_column :actors, :relevant_year, :boolean, default: false
    rename_column :actors, :relevant_year, :year_2011
    add_column :actors, :year_2012, :boolean,default: false
    add_column :actors, :year_2013, :boolean,default: false
  end
end
