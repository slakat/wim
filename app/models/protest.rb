class Protest < ActiveRecord::Base
  belongs_to :actor

  def self.total_rt(date,nature)
  	actors = Actor.where(nature: nature)
  	total = 0
  	protest_total=Protest.where(protest: date).count
  	actors.each do |a|
  		rt = a.protests.where(protest: date).count
  		total = total+ rt
	end
	puts (total.fdiv(protest_total)*100)
	(total.fdiv(protest_total).round(2)*100).round(2)
  end

  def self.by_year
    y2011 = Protest.where("YEAR(protest) = 2011").count
    y2012 = Protest.where("YEAR(protest) = 2012").count
    y2013 = Protest.where("YEAR(protest) = 2013").count
    [y2011,y2012,y2013]
  end
end
