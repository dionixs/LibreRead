class NotesController < ApplicationController
  before_action :find_note, only: %i[show edit update destroy]

  def index
    @notes = Note.all
  end

  def show; end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(notes_params)
    if @note.save
      redirect_to notes_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @note.update(notes_params)
      redirect_to notes_path
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path
  end

  private

  # todo
  def notes_params
    params.require(:note).permit(:title, :clipping)
  end

  def find_note
    @note = Note.find(id: params[:id])
  end
end
