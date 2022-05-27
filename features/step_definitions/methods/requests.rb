class Requests

  def get_file(parameter)
    if parameter.include? 'pet'
      file = $petReqDir
    elsif parameter.include? 'order'
      file = $orderReqDir
    else
      raise StandardError, '******Incorrect parameter******'
    end
    File.read(file)
  end

  def replace_status(request, status = 'available')
    request.sub! 'STATUS', status
  end

  def replace_id(request, id = $random)
    request.sub! '"ID"', id.to_s
  end

  def request_method(url, method, status, id)
    default = Default.new
    begin
      case method
      when 'GET'
        uri = url + status.to_s + id.to_s
        $response = HTTParty.get(uri)
      when 'DELETE'
        uri = url + id.to_s
        $response = HTTParty.delete(uri)
      end
    rescue StandardError => e
      default.error "Error - #{e}"
    end    
    default.info 'URL: ' + uri.to_s
    default.info 'Response: ' + $response.to_s
    $response
  end

  def post_method_with_request(url, request)
    default = Default.new
    uri = URI(url)
    default.info 'URL: ' + uri.to_s
    default.info 'POST request: ' + request.to_s
    $response = HTTParty.post(uri, body: request.to_s, headers: { 'Content-Type' => 'application/json' })
    default.info 'Response: ' + $response.to_s
    $response
  end


  def update_request(url,id, status)
    default = Default.new
    uri = URI(url)
    default.info 'URL: ' + uri.to_s
    array = ['available', 'pending', 'sold']
    array.delete(status)
    $newStatus = array.sample
    begin
      request = JSON.parse(get_file(url))
      request = replace_status(request.to_json, $newStatus)
      request = replace_id(request, id)
      default.info 'Update request: ' + request.to_s
      $response = HTTParty.put(uri, body: request.to_s, headers: { 'Content-Type' => 'application/json' })
    rescue StandardError => e
      default.error "Error - #{e}"
    end
    default.info 'Response is: ' + $response.to_s
    $response
  end

  def create_request(parameter)
    request = JSON.parse(get_file(parameter)).to_json
    request = replace_status(request) unless parameter == 'order'
    request = replace_id(request)
    $request = request
  end

end
