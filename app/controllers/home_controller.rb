class HomeController < ApplicationController
  def index
    
    @place1 = Duck.where(region: 1).order("id desc")
    @place2 = Duck.where(region: 2).order("id desc")




  end
  
  def write
    duck = Duck.new
    duck.region = params[:region]
    duck.mtype = params[:type]
    duck.name = params[:name]
    duck.address = params[:address]
    duck.daddress = params[:daddress]
    duck.mlong= 127.017784
    duck.mlat = 37.484709
    uploader = DuckUploader.new
    uploader.store!(params[:pic])

    duck.image_url = uploader.url

    if duck.save
      redirect_to "/home/index"
    else
      render :text => post.errors.messages[:title].first
    end
  end

  def new
    
  end

  def edit
  end
  
  def test
    
  end
end