# frozen_string_literal: true

RUSSIAN_MONTH_NAMES = {
  'января' => 'january',
  'февраля' => 'february',
  'марта' => 'march',
  'апреля' => 'april',
  'мая' => 'may',
  'июня' => 'june',
  'июля' => 'july',
  'августа' => 'august',
  'сентября' => 'september',
  'октября' => 'october',
  'ноября' => 'november',
  'декабря' => 'december'
}

# todo
class ClippingsParser
  attr_reader :notes, :raw_notes

  def initialize(data)
    @raw_notes = to_raw_notes(data)
    @units = to_units(@raw_notes)
    @notes = extract_notes
  end

  def extract_notes(notes = [])
    return nil if @units.nil?
    @units.each do |unit|
      note = {}
      # Получаем имя автора книги
      note[:author] = get_author(unit)
      # Получаем название книги
      note[:title] = get_title(unit)
      # Получаем место выделенного отрывка
      note[:place] = get_place(unit)
      # Получаем время добавления заметки
      note[:created_kindle_at] = get_time(unit)
      # Получаем заметку
      note[:clipping] = get_note(unit)
      notes << note
    end
    notes
  end

  private

  # todo
  # Метод to_raw_notes разбивает строку
  # и возвращает массив необработанных заметок
  def to_raw_notes(string)
    if string.split.include?('==========')
      string.strip.split('==========')
    else
      nil
    end
  end

  # Метод to_units возращает массив в котором:
  # Первый элемент (строка) содержит название книги, вместе с автором.
  # А второй элемент (строка) содержит саму заметку и данные о ней.
  def to_units(array)
    array.map(&statement_unit) unless array.nil?
  end

  def get_title(array)
    array[0].split(/\(.*?\)/)[0].strip
  end

  def get_author(array)
    author = array[0].strip.scan(/\(([^()]*)\)/)[-1]
    author.nil? ? nil : author.join
  end

  # Метод get_place возвращает место выделенного отрывка
  def get_place(array)
    if split_details(array).nil?
      nil
    else
      split_details(array)[0][/\d+.\d+/]
        .split('–')[0]
    end
  end

  # todo
  # Метод get_time возвращает время добавления заметки
  def get_time(array)
    return nil if split_details(array).nil?
    array = split_details(array)[0].split('|')[-1]
              .split(',')[1].split('.')
    date = date(array)
    time = array[-1].split[-1].split(':')
    Time.new(date[:year], date[:mon], date[:mday], time[0], time[1], time[2])
  end

  # Метод get_note возвращает заметку
  def get_note(array)
    if split_details(array).nil?
      nil
    else
      split_details(array)[-1].strip
    end
  end

  def statement_unit
    proc { |item| item.split("\r\n–") }
  end

  def split_details(array)
    array[1].nil? ? nil : array[1].split("\r\n\r\n")
  end

  # todo
  def date(array)
    date = array[0].split[0..-2]
    month = RUSSIAN_MONTH_NAMES[date[1]].capitalize
    date[1] = Date::MONTHNAMES.index(month)
    date = date.reverse
    Date._parse("#{date[0]}-#{date[1]}-#{date[2]}")
  end
end
