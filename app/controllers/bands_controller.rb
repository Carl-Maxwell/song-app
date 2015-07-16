class BandsController < ApplicationController
  def index
    @bands = Band.all
  end

  def create

  end

  def new
    @band = Band.new
  end

  def edit
    @band = Band.find(params[:id])
  end

  def show
    @band = Band.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
