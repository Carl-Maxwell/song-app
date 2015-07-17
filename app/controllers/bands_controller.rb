class BandsController < ApplicationController
  before_action :require_user

  def index
    @bands = Band.all.order(:created_at)
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to band_url(@band)
    else
      render :create
    end
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
    @band = Band.find(params[:id])

    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])

    @band.destroy!

    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
