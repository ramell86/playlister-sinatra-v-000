require 'pry'
require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash


    get '/songs' do
    @songs = Song.all
    erb :'songs/index'
end

    get '/songs/new' do
        
        erb :'songs/new'
    end 

    post '/songs' do
      
            @song = Song.create(:name =>params["song"]["name"])
            @song.artist = Artist.find_or_create_by(:name => params["artist"]["name"])
            @song.genre_ids = params["genres"]
            @song.save
                flash[:message] = "Successfully created song."

        redirect to "/songs/#{@song.slug}"
    end



    get '/songs/:slug/edit' do
        @songs = Song.find_by_slug(params["slug"])
        @genres = Genre.all
        erb :"/songs/edit"
    end

    get '/songs/:slug' do
        
        @songs = Song.find_by_slug(params["slug"])
        
        erb :'songs/show'
    end

    post '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @song.artist = Artist.find_or_update_by(:name => params["artist"]["name"])
        @song.update(params["song"])

        redirect to "/songs/#{@song.slug}"
    end


end