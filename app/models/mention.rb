class Mention < ActiveRecord::Base
  belongs_to :actor

  def self.search_by_prefix (prefix)
    where("lower(text) LIKE '#{prefix.downcase}%'")
  end
end
