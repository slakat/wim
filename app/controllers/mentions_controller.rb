class MentionsController < ApplicationController
  before_filter :set_user, only: [:index]
  helper_method :sort_column, :sort_direction


  def index
    #@mentions=Retweet.where(actor_id: 3).pluck(:id)
    @table = Actor.find(1).retweets.group('text').order('count_text DESC').limit(100).count('text')

    #all = Retweet.pluck(:text)
    #time = Retweet.uniq.pluck(:text)

    #@mentions.each do |r|
       #date = r.mention_date.to_datetime
       #Retweet.create!(actor_id: r.actor_id,mention_id: r.id, text: r.text, user_screen_name: r.user_screen_name, rt_date: date)

    #end

    if request.xhr?
      render partial: 'retweets_table'
    else
      render :index
    end


  end

  private
  def set_user
    @user = Actor.find(1)
  end

  def sort_column
    Retweet.has_column_text?(params[:sort]) ? params[:sort] : :text
  end

  def per_page
    params[:page_limit] || 10
  end

end
