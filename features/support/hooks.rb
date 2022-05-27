Before do |scenario|
  default = Default.new
  default.info('*Scenario: ' + scenario.name)
  $scenario = scenario
  $step_index = 0
end


AfterStep do |result, test_step|
  default = Default.new
  default.info(test_step.text + ' is PASSED')
  $step_index += 2
end


After do |scenario|
  default = Default.new
  if scenario.failed?
    step = $scenario.test_steps[$step_index].text
    err = scenario.exception.to_s
    default.error('ERROR in step "' + step + '" with message: ' + err.delete!("\r\n\\"))
  end
  default.info('*Scenario end.')
end