class NotesController < ApplicationController
  def create
    @note = Note.new(note_params.merge(user: current_user))

    @note.save

    redirect_to track_url(@note.track)
  end

  def destroy
    @note = Note.find(params[:id])

    if @note.user != current_user
      render text: "You are forbidden", status: 403
    else
      @note.destroy!

      redirect_to track_url(@note.track)
    end
  end

  private

  def note_params
    params.require(:note).permit(:body, :track_id)
  end
end
