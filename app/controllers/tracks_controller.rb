class TracksController < ApplicationController
  before_action :require_user

  def index
    @tracks = Track.all
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      render :create
    end
  end

  def new
    @track = Track.new(album_id: params[:album_id])
  end

  def edit
    @track = Track.find(params[:id])
  end

  def show
    @track = Track.find(params[:id])
    @note = Note.new(track: @track)
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])

    @track.destroy!

    redirect_to tracks_url
  end

  private

  def track_params
    params.require(:track).permit(:name, :bonus_or_regular, :lyrics, :album_id)
  end
end
