# frozen_string_literal: true

# todo
class ClippingsParser
  attr_reader :raw_notes, :notes, :units

  SEPARATOR = '=========='

  MONTH_NAMES = {
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
  }.freeze

  def initialize(data)
    @raw_notes = create_raw_notes(data)
    @units = create_units(@raw_notes)
    @notes = []
  end

  def extract_notes
    return if @units.nil? || @units[0].size != 3

    @units.each { |unit| @notes << get_note(unit) }
    @notes
  end

  private

  # Метод create_raw_notes разбивает строку
  # и возвращает массив необработанных заметок
  def create_raw_notes(string)
    return unless include_separator?(string)

    arr = string.strip.split(SEPARATOR)
    arr.empty? ? nil : arr
  end

  # Метод create_units возращает массив строк в котором:
  # Первый элемент содержит название книги, вместе с автором.
  # Второй элемент содержит данные о заметке.
  # Третий элемент содержит саму заметку
  def create_units(raw_notes)
    return if raw_notes.blank?

    raw_notes.map do |item|
      item.split("\r\n").compact_blank
    end
  end

  def get_note(unit)
    {
      author: get_author(unit),
      title: get_title(unit),
      place: get_place(unit),
      created_kindle_at: get_time(unit),
      clipping: get_clipping(unit)
    }
  end

  def get_title(unit)
    unit[0].split(/\(.*?\)/)[0].strip
  end

  def get_author(unit)
    author = unit[0].strip.scan(/\(([^()]*)\)/)[-1]
    author.nil? ? nil : author.join
  end

  # Метод get_place возвращает место выделенного отрывка
  def get_place(unit)
    delimiters = %w[– -]
    loc = unit[1][/\d+.\d+/].split(Regexp.union(delimiters))
    loc[0]
  end

  # Метод get_time возвращает время добавления заметки
  def get_time(unit)
    raw_time = raw_time(unit)
    raw_date = raw_date(unit)
    parse_time(date(raw_date), time(raw_time))
  end

  def parse_time(date, time)
    Time.zone.local(date[:year], date[:mon], date[:mday], time[0], time[1], time[2])
  end

  # todo
  def date(raw_date)
    month = ru_lang?(raw_date) ? MONTH_NAMES[raw_date[1]].capitalize : raw_date[1]
    raw_date[1] = Date::MONTHNAMES.index(month)
    Date._parse("#{raw_date[0]}-#{raw_date[1]}-#{raw_date[2]}")
  end

  # todo
  def time(arr)
    time = arr[0].split(':')
    if arr.size == 2
      abbreviation = arr[1].downcase
      hour = Time.strptime("#{time[0].to_i - 1}#{abbreviation}", '%I%P').strftime('%H')
      time[0] = hour
    end
    time
  end

  # todo
  def raw_time(unit, delimiters = %w[, .], abbreviation = nil)
    arr = split_details(unit)
          .split(Regexp.union(delimiters))[-1].split
    abbreviation = arr[-1] if arr.size == 3
    arr = arr.filter_map { |item| item if item.include?(':') }
    arr.push(abbreviation) unless abbreviation.nil?
    arr
  end

  # todo
  def raw_date(unit)
    arr = split_details(unit).split(',')

    return eng_version_date(arr) if eng_lang?(arr)

    arr[1].split('.')[0].split
  end

  # todo
  def eng_version_date(arr)
    arr = arr[1..].join
    arr = arr.split.filter_map { |item| item unless item.include?(':') }[0..-2]
    arr[0], arr[1], arr[2] = arr[1], arr[0], arr[2]
  end

  # Метод get_clipping возвращает заметку
  def get_clipping(unit)
    return if unit.nil?

    unit[2].strip
  end

  def split_details(unit)
    unit[1].split('|')[-1]
  end

  def include_separator?(string)
    string.split.include?(SEPARATOR)
  end

  def eng_lang?(obj)
    detect_lang(obj) == 'en'
  end

  def ru_lang?(obj)
    detect_lang(obj) == 'ru'
  end

  def detect_lang(obj)
    CLD.detect_language(obj)[:code]
  end
end
