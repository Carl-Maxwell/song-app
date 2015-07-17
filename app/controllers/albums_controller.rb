class AlbumsController < ApplicationController
  before_action :require_user

  def index
    @albums = Album.all
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      render :create
    end
  end

  def new
    @album = Album.new(band_id: params[:band_id] )
  end

  def edit
    @album = Album.find(params[:id])
  end

  def show
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])

    @album.destroy!

    redirect_to albums_url
  end

  private

  def album_params
    params.require(:album).permit(:name, :live_or_studio, :band_id)
  end
end
