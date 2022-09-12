module ImportsHelper
  def short_name(name)
    if name.size > 50
      "#{name[0..49]}..."
    else
      name
    end
  end
end
