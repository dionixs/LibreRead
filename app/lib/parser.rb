# frozen_string_literal: true

class Parser
  attr_reader :notes

  def initialize(file_name)
    @file = File.read(file_name)
    @raw_notes = to_raw_notes(@file)
    @units = to_units(@raw_notes)
    @titles = @units.map(&statement_title).uniq
    @notes = extract_notes
  end

  def extract_notes(notes = create_titles)
    @units.each_with_object(Hash.new(0)) do |unit, note|
      # Получаем место выделенного отрывка
      note[:place] = get_place(unit)
      # Получаем время добавления выделенного отрывка
      note[:datetime] = get_datetime(unit)
      # Получаем заметку
      note[:note] = get_note(unit)

      notes[get_title(unit)] << note
    end
    notes
  end

  private

  # Метод to_raw_notes разбивает строку
  # и возвращает массив необработанных заметок
  def to_raw_notes(string)
    string.strip.split('==========')
  end

  # Метод to_units возращает массив в котором:
  # Первый элемент (строка) содержит название книги.
  # А второй элемент (строка) содержит саму заметку и данные о ней.
  def to_units(array)
    array.map(&statement_unit)
  end

  # Метод create_titles возвращает хэш вида:
  # {"Название книги"=>[], "Название книги"=>[]}
  def create_titles
    @titles.flat_map { |t| [t, []] }
           .each_slice(2)
           .to_a.to_h
  end

  # Метод get_title возвращает название книги (вместе с автором)
  def get_title(array)
    array[0].strip
  end

  # Метод get_place возвращает место выделенного отрывка
  def get_place(array)
    split_unit(array)[0].strip
  end

  # Метод get_datetime возвращает время добавления выделенного отрывка
  def get_datetime(array)
    split_unit(array)[1]
      .split("\r\n\r\n")[0].strip
  end

  # Метод get_note возвращает заметку
  def get_note(array)
    split_unit(array)[1]
      .split("\r\n\r\n")[1].strip
  end

  def statement_unit
    proc { |item| item.split("\r\n–") }
  end

  def statement_title
    proc { |item| get_title(item) }
  end

  # Метод для разбивки массива на составляющие
  def split_unit(array)
    array[1].split('|')
  end
end
