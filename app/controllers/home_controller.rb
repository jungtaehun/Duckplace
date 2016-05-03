class HomeController < ApplicationController
  def index
    @every_post = Duck.all.order("id desc")
  end

  def new
  end

  def edit
  end
end
