class Protest < ActiveRecord::Base
  belongs_to :actor

  def self.total_rt(date,nature)
    year =  date.to_date.strftime("%Y")

    case year
      when "2011"
        actors = Actor.where(nature: nature, year_2011: true)
        pseudo_total_protest = Protest.where("YEAR(protest) = 2011").joins(:actor).where(actors: { year_2011: true })
      when "2012"
        actors = Actor.where(nature: nature, year_2012: true)
        pseudo_total_protest = Protest.where("YEAR(protest) = 2012").joins(:actor).where(actors: { year_2012: true })
      when "2013"
        actors = Actor.where(nature: nature, year_2013: true)
        pseudo_total_protest = Protest.where("YEAR(protest) = 2013").joins(:actor).where(actors: { year_2013: true })
    end

  	total = 0
  	protest_total=pseudo_total_protest.where(protest: date).count

  	actors.each do |a|
  		rt = a.protests.where(protest: date).count
  		total = total+ rt
    end
    puts total, protest_total
	puts (total.fdiv(protest_total)*100)
	(total.fdiv(protest_total).round(2)*100).round(2)
  end

  def self.by_year
    y2011 = Protest.where("YEAR(protest) = 2011").joins(:actor).where(actors: { year_2011: true }).count
    y2012 = Protest.where("YEAR(protest) = 2012").joins(:actor).where(actors: { year_2012: true }).count
    y2013 = Protest.where("YEAR(protest) = 2013").joins(:actor).where(actors: { year_2013: true }).count
    [y2011,y2012,y2013]
  end
end
