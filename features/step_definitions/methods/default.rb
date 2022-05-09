class Default
  def valid_json?(response)
    JSON.parse(response.to_s)
    true
  rescue JSON::ParserError => e
    false
  end
end
