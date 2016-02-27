class RetweetsController < ApplicationController
  before_filter :set_actor, only: [:index, :download]
  helper_method :sort_column, :sort_direction


  def index
    #@mentions=Mention.where('text LIKE ?', 'RT @camila_vallejo%')
    #all = Retweet.pluck(:text)
    #time = Retweet.uniq.pluck(:text)
    @actor = Actor.find(@actor.id)
    @table = Actor.find(@actor.id).retweets.group('text').order('count_text DESC').count('text')
    @keys= @table.keys.paginate(:per_page => per_page, :page => params[:page])
    @mentions = @keys
    #puts time.count
    #puts all.count
    # @mentions.each do |r|
    #   date = r.mention_date.to_datetime
    #   Retweet.create!(actor_id: 1,mention_id: r.id, text: r.text, user_screen_name: r.user_screen_name, rt_date: date)
    #   puts r
    #   puts date
    # end
=begin
    #@keys= @table.keys
    @keys.each do |key|
      k = key.partition(': ').last[0...-4]
      puts k

      t = Actor.find(@actor.id).tweets.where(["text LIKE ?", "%#{k.gsub("'", "''")}%"]).first
      if t
        tDate = t.tweet_date
      end
      unless t
        t =Actor.find(@actor.id).retweets.find_by_text(key).mention
        tDate = t.mention_date
      end

      RankingTweet.create!(actor_id: @actor.id,tweet_date: tDate,favorited: t.favorited, in_reply_to_screen_name: t.in_reply_to_screen_name,permanent_link: t.permanent_link,lang: t.lang,source: t.source, text: t.text,user_profile_description: t.user_profile_description,user_profile_location: t.user_profile_location,user_date: t.user_date, user_followers_count: t.user_followers_count,user_name: t.user_name, user_screen_name: t.user_screen_name,user_time_zone: t.user_time_zone, retweets: @table[key].to_s)
=end


    #end

    if request.xhr?
      render partial: 'retweets_table'
    else
      render :index
    end
  end

    def download
      #@rt = RankingTweet.where(" actor_id = ? AND retweets > ?",@actor.id, 99)
      @rt = RankingTweet.where(" actor_id = ?",@actor.id)
      puts 'hola'
      respond_to do |format|
        format.html
        format.csv do
          headers['Content-Disposition'] = "attachment; filename=\"retweets\""
          headers['Content-Type'] ||= 'text/csv'
        end
        format.xlsx {render xlsx: 'ranking',filename: "#{@actor.screen_name}_MostRT.xlsx"}
      end
    end

  def retweets
    #@rt = Actor.first.retweets.where("text LIKE ?","%Hoy a las 21 horas cacerolazo%").order(:rt_date)
    actor=Actor.find(params[:id])
    @rt = actor.retweets
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"#{actor.screen_name}-RT.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
      format.xlsx {render xlsx: 'retweets',filename: "#{actor.screen_name}RT.xlsx"}
    end
  end

    def ranking
      #@rt = RankingTweet.where(" actor_id = ? AND retweets > ?",@actor.id, 99)
      @rt = RankingTweet.order('retweets DESC').limit(500)


      respond_to do |format|
        format.html
        format.csv do
          headers['Content-Disposition'] = "attachment; filename=\"retweets-ranking-300.csv\""
          headers['Content-Type'] ||= 'text/csv'
        end
        format.xlsx {render xlsx: 'ranking',filename: "retweets-ranking-300.xlsx"}
      end

    end

  def protests
    #@rt = RankingTweet.where(" actor_id = ? AND retweets > ?",@actor.id, 99)
    @rt = Actor.first.retweets.created_between(params[:p].to_date-3.days,params[:p].to_date+4.days)


    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"marcha-#{params[:p]}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
      format.xlsx {render xlsx: 'protests',filename: "marcha-#{params[:p]}.xlsx"}
    end

  end


  def zip
    filename = 'marchas.zip'
    temp_file = Tempfile.new(filename)

    begin
      #This is the tricky part
      #Initialize the temp file as a zip file
      Zip::OutputStream.open(temp_file) { |zos| }

      #Add files to the zip file as usual
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
        #Put files in here
        dates = ["2011-05-12".to_date,"2011-05-26".to_date,"2011-06-01".to_date,"2011-06-16".to_date,"2011-06-23".to_date,"2011-06-30".to_date,"2011-07-14".to_date,"2011-08-04".to_date,"2011-08-18".to_date,"2011-08-24".to_date,"2011-09-22".to_date,"2011-09-29".to_date,"2011-10-18".to_date,"2012-04-25".to_date,"2012-05-16".to_date,"2012-08-08".to_date,"2012-08-28".to_date,"2012-09-27".to_date,"2013-04-11".to_date,"2013-05-08".to_date,"2013-05-28".to_date,"2013-06-13".to_date,"2013-06-26".to_date,"2013-07-11".to_date,"2013-09-05".to_date,"2013-10-17".to_date]
        dates.each do|d|
          zip.get_output_stream("#{d}.csv") { |f| f.puts(Retweet.to_csv(d)) }
        end
      end

      #Read the binary data from the file
      zip_data = File.read(temp_file.path)

      #Send the data to the browser as an attachment
      #We do not send the file directly because it will
      #get deleted before rails actually starts sending it
      send_data(zip_data, :type => 'application/zip', :filename => filename)
    ensure
      #Close and delete the temp file
      temp_file.close
      temp_file.unlink
    end
  end



  private
  def set_actor
    @actor = Actor.find(params[:actor_id])
  end

  def sort_column
    Retweet.has_column_text?(params[:sort]) ? params[:sort] : :text
  end

  def per_page
    params[:page_limit] || 10
  end

end
