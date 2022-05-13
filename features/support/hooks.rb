Before do |scenario|
  default = Default.new
  default.info('----- Test Case start -----')
end

After do |scenario|
  default = Default.new
  default.info('----- Test Case finish -----')
  if scenario.failed?
    # encoded_img = $driver.screenshot_as(:base64)
  end
end