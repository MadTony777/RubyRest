Before do |scenario|
  default = Default.new
  default.info('----- Test Case start -----')
end

After do |scenario|
  default = Default.new
  default.info('----- Test Case finish -----')
end