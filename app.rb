require_relative 'middleware/time'

class App
  def call(env)
    request = Rack::Request.new(env)

    return not_found unless request.path == '/time'

    timestring = TimeString.new(request.params['format'])

    if timestring.valid?
      correct_answer(timestring.formatted_time)
    else
      bad_request("Unknow time format: #{timestring.invalid_params}")
    end
  end

  private

  def response(status:, headers: { 'Content-Type' => ' text/plain' }, body: nil)
    [status, headers, ["#{body}\n"]]
  end

  def not_found
    response(status: 404, body: "not found")
  end

  def correct_answer(body)
    response(status: 200, body: body)
  end

  def bad_request(body)
    response(status: 400, body: body)
  end
end
