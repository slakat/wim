class Retweet < ActiveRecord::Base
  belongs_to :actor
  belongs_to :mention
  has_one :tweet


  scope :created_between, lambda {|start_date, end_date| where("rt_date >= ? AND rt_date <= ?", start_date, end_date )}

  def self.to_csv(p)
    @rt = Protest.where(protest: p)
    CSV.generate( :row_sep => ?\n, :quote_char => ?\ ) do |csv|
      headers = ['source', 'target', 'date', 'protest','nature','relevant_year' ]
      csv << headers
      @rt.each do |m|
        year = false
        puts m
        actor = Actor.where(real_username: m.to).first
        unless actor.nil?
          case p.to_date.strftime("%Y")
            when "2011"
              year = actor.year_2011
            when "2012"
              year =  actor.year_2012
            when "2013"
              year = actor.year_2013
          end
          if year
            csv << [m.to, m.from, m.created_date, m.protest,actor.nature,p]
          end
        end
      end
    end
  end

end
