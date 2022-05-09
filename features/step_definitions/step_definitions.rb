requests = Requests.new
default = Default.new

When(/^Send "(.*)" to the "(.*)" with status "(.*)"$/) do |method, url, status|
  $status = status
  requests.request_method(url, method, $status, nil)
end

When(/^Send "(.*)" to the "(.*)" with ID$/) do |method, url|
  requests.request_method(url, method, nil, $id)
end

When(/^Send create request to the "(.*)" url$/) do |url|
  requests.noparams_method(url)
end

And(/^Check that response code equals "(.*)"$/) do |status_code|
  expect($response.code.to_s).to eq(status_code)
end

And(/^Check that response valid$/) do
  default.valid_json?($response)
end

And(/^Check that there are no others statuses in response$/) do
  $statuses.delete($status)
  array = $statuses
  array.each do |i|
    raise StandardError, '******Response contains resord with incorrect status******' if $response.include? i
  end
end

And(/^Check that response contains new status$/) do
  obj = JSON.parse($response.to_s)
  status = obj['status']
  expect(status).to eq('sold')
end

And(/^Get id from response$/) do
  obj = JSON.parse($response.to_s)
  $id = obj['id']
end
