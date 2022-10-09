# frozen_string_literal: true

# TODO
module NoteHandling
  extend ActiveSupport::Concern

  included do
    private

    # Refactoring
    def find_note!
      @note = @import.notes.find(params[:id]).decorate
    end

    def import_notes(import, notes)
      notes = notes.each_with_object([]) do |note, array|
        note[:user_id] = current_user.id
        array << import.notes.build(note)
      end
      Note.import notes, recursive: true
    end

    def saved_notes_for_current_user(user)
      old_notes = Note.where(user_id: user.id)
      old_notes = old_notes.map(&:attributes)
      symbolize_keys_in_array_hashes(old_notes)
    end

    def symbolize_keys_in_array_hashes(notes)
      notes.each_with_object([]) do |saved_note, array|
        array << saved_note.symbolize_keys
      end
    end

    def unique_notes_for_import(new_notes, old_notes)
      new_notes&.each_with_object([]) do |hash, array|
        array << hash unless old_notes.any? do |hash2|
          hash[:clipping] == hash2[:clipping]
        end
      end
    end
  end
end
