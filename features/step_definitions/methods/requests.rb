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
    uri = URI(url)
    case method
    when 'GET'
      uri = url + status.to_s + $id.to_s
      $logger.info 'URL: ' + uri.to_s
      $response = HTTParty.get(uri)
    when 'POST'
      $logger.info 'URL: ' + uri.to_s
      request = JSON.parse(get_file(url)).to_json
      request = replace_status(request, status)
      request = replace_id(request, id)
      $logger.info 'POST request is: ' + request.to_s
      $response = HTTParty.post(uri, body: request.to_s, headers: { 'Content-Type' => 'application/json' })
    when 'PUT'
      $logger.info 'URL: ' + uri.to_s
      request = JSON.parse(get_file(url))
      request = replace_status(request.to_json, 'sold')
      request = replace_id(request, id)
      $logger.info 'PUT request is: ' + request.to_s
      $response = HTTParty.put(uri, body: request.to_s, headers: { 'Content-Type' => 'application/json' })
    when 'DELETE'
      uri = url + $id.to_s
      $logger.info 'URL: ' + uri.to_s
      $response = HTTParty.delete(uri)
    end
    $logger.info 'Response is: ' + $response.to_s
    $response
  end

  def noparams_method(url)
    uri = URI(url)
    $logger.info 'URL: ' + uri.to_s
    request = JSON.parse(get_file(url)).to_json
    request = replace_status(request)
    request = replace_id(request)
    $logger.info 'POST request is: ' + request.to_s
    $response = HTTParty.post(uri, body: request.to_s, headers: { 'Content-Type' => 'application/json' })
    $logger.info 'Response is: ' + $response.to_s
    $response
  end
end
