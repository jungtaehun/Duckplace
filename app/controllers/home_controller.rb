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

  def second
    sec_name = params[:name]
    sec_address = params[:address]

    if sec_name == "" and sec_address == ""
      #다시 시도하세요.
    elsif sec_name == ""
      #주소로 검색

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

    else
      #가게 이름으로 검색(수정해야함)

      uri = URI(URI.encode("https://openapi.naver.com/v1/search/local.xml?query=#{params[:name]}"))

      req = Net::HTTP::Get.new(uri)
      req['X-Naver-Client-Id'] = "DZaaw4YVOevidOL4rL06"
      req['X-Naver-Client-Secret'] = "AgZIyTdxqI"

      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
        http.request(req)}

      parsed = JSON.parse(res.body)["result"]["items"][0]
      duck.address = parsed["address"]
      duck.mlong = parsed["point"]["x"]
      duck.mlat = parsed["point"]["y"]

    end

    #그다음 결과값을 나열해서 선택하게 한다.
    #결과값이 정해지면 그 값을 데이터에 저장한다.
    #결과값에 없다면 사용자가 일일이 쓰게 하거나, 닫기를 선택해 다시 메인으로 돌아오게 한다.


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