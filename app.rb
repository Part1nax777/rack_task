require_relative 'middleware/time'

class App

  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    response.set_header('Content-Type', 'text/plain')

    if request.path == '/time'
      time_response(request, response)
    else
      not_found_response(response)
    end

    response.finish
  end

  private

  def time_response(request, response)
    params = request.params

    unless has_format_params?(params)
      response.status = 400
      response.body = ['Bad query']
      return
    end

    timestring = TimeString.new(params['format'])
    response.body.push(timestring.form_time_string)

    if response.body[0][0..6] == 'Unknown'
      response.status = 200
    else
      response.status = 400
    end
  end

  def not_found_response(response)
    response.status = 404
    response.body = ['Bad path']
  end

  def has_format_params?(params)
    params.keys.include?('format') && params['format']
  end
end



