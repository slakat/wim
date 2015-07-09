class Retweet < ActiveRecord::Base
  belongs_to :actor
  belongs_to :mention
  has_one :tweet


  scope :created_between, lambda {|start_date, end_date| where("rt_date >= ? AND rt_date <= ?", start_date, end_date )}

  def self.to_csv(p)
    @rt = Protest.where(protest: p)
    CSV.generate( :row_sep => ?\n, :quote_char => ?\ ) do |csv|
      headers = ['to', 'from', 'date', 'protest' ]
      csv << headers
      @rt.each do |m|
        csv << [m.to, m.from, m.created_date, m.protest ]
      end
    end
  end

end
