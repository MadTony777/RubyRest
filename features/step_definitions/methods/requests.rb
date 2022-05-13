class Requests

  

  def get_file(url)
    if url.include? '/pet'
      file = 'features/step_definitions/requests/pet.json'
    elsif url.include? '/store/order'
      file = 'features/step_definitions/requests/order.json'
    else
      raise StandardError, '******Incorrect url for this method******'
    end
    File.read(file)
  end

  def replace_status(request, status = 'available')
    request.sub! 'STATUS', status
  end

  def replace_id(request, id = $random)
    request.sub! 'ID', id.to_s
  end

  def request_method(url, method, status, id)
    default = Default.new
    uri = URI(url)
    begin
      case method
      when 'GET'
        uri = url + status.to_s + $id.to_s
        default.info 'URL: ' + uri.to_s
        $response = HTTParty.get(uri)
      when 'POST'
        default.info 'URL: ' + uri.to_s
        request = JSON.parse(get_file(url)).to_json
        request = replace_status(request, status)
        request = replace_id(request, id)
        default.info 'POST request is: ' + request.to_s
        $response = HTTParty.post(uri, body: request.to_s, headers: { 'Content-Type' => 'application/json' })
      when 'PUT'
        default.info 'URL: ' + uri.to_s
        request = JSON.parse(get_file(url))
        request = replace_status(request.to_json, 'sold')
        request = replace_id(request, id)
        default.info 'PUT request is: ' + request.to_s
        $response = HTTParty.put(uri, body: request.to_s, headers: { 'Content-Type' => 'application/json' })
      when 'DELETE'
        uri = url + $id.to_s
        default.info 'URL: ' + uri.to_s
        $response = HTTParty.delete(uri)
      end
    rescue StandardError => e
      default.error "Error - #{e}"
    end
    default.info 'Response is: ' + $response.to_s
    $response
  end

  def noparams_method(url)
    default = Default.new
    uri = URI(url)
    default.info 'URL: ' + uri.to_s
    begin
      request = JSON.parse(get_file(url)).to_json
      request = replace_status(request)
      request = replace_id(request)
      default.info 'POST request is: ' + request.to_s
      $response = HTTParty.post(uri, body: request.to_s, headers: { 'Content-Type' => 'application/json' })
    rescue StandardError => e
      default.error "Error - #{e}"
    end
    default.info 'Response is: ' + $response.to_s
    $response
  end
end
