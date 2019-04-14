class TimeString
  TIME_FORMATS = [
    "year",
    "month",
    "day",
    "hour",
    "minute",
    "second"
  ]

  def initialize(time)
    @time = time.split(',')
  end

  def form_time_string
    unknown_formats = []
    @time.each do |t|
      unknown_formats.push(t) unless TIME_FORMATS.include?(t)
    end

    return ("Unknown time format: #{unknown_formats}") unless unknown_formats.empty?

    final_string = ""
    @time.each do |t|
      final_string += "#{ Time.now.send(t) }-"
    end

    final_string.chomp!("-")
    final_string += "\n"
    final_string
  end
end
