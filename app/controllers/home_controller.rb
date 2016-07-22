require 'net/http'
require 'nokogiri'
require "json"

class HomeController < ApplicationController
  def index
    
    @place1 = Duck.where(region: 1).order("id desc")
    @place2 = Duck.where(region: 2).order("id desc")




  end

  def detail

    @detail = Duck.find(params[:id])


  end
  
  def write
    duck = Duck.new
    duck.region = params[:region]
    duck.mtype = params[:type]
    duck.name = params[:name]
    duck.daddress = params[:daddress]


    uri = URI(URI.encode("https://openapi.naver.com/v1/map/geocode?query=#{params[:address]}"))

    req = Net::HTTP::Get.new(uri)
    req['X-Naver-Client-Id'] = "DZaaw4YVOevidOL4rL06"
    req['X-Naver-Client-Secret'] = "AgZIyTdxqI"

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
      http.request(req)}

    parsed = JSON.parse(res.body)["result"]["items"][0]
    duck.address = parsed["address"]
    duck.mlong = parsed["point"]["x"]
    duck.mlat = parsed["point"]["y"]


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