class Default

  def valid_json?(response)
    JSON.parse(response.to_s)
    true
  rescue JSON::ParserError => e
    false
  end

  def info(message)
    if ARGV.include?("Jenkins=true")
      logger = Logger.new(STDOUT)
    else
      logger = Logger.new('my_logs.log')
    end
    logger.info message
  end
  
  def error(message)
    if ARGV.include?("Jenkins=true")
      logger = Logger.new(STDOUT)
    else
      logger = Logger.new('my_logs.log')
    end
    logger.error message
  end

end