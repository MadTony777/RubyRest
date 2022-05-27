requests = Requests.new
default = Default.new

When(/^Send "(.*)" to the "(.*)" with "(.*)"$/) do |method, url, param|
  if param == 'id'
    requests.request_method(url, method, nil, $id)
  elsif param == 'request'
    requests.post_method_with_request(url, $request)
  else
    $status = param
    requests.request_method(url, method, $status, nil)
  end
end

When(/^Update pet by changing status$/) do
  array = ['available', 'pending', 'sold']
  array.delete($status)
  status = array.sample
  requests.update_request("https://petstore.swagger.io/v2/pet", $id, status)
end

When(/^Create "(.*)" with status "(.*)"$/) do |parameter, status|
  $status = status unless status.nil?
  requests.create_request(parameter)
end

And(/^Check that response code equals "(.*)"$/) do |status_code|
  expect($response.code.to_s).to eq(status_code)
end

And(/^Check that response valid$/) do
  default.valid_json?($response)
end

And(/^Check that there are no others statuses in response$/) do
  array = ['available', 'pending', 'sold']
  array.delete($status)
  array.each do |i|
    raise StandardError, '******Response contains resord with incorrect status******' if $response.include? i
  end
end

And(/^Check that response contains new status$/) do
  obj = JSON.parse($response.to_s)
  status = obj['status']
  expect(status).to eq($newStatus)
end

And(/^Get id from response$/) do
  obj = JSON.parse($response.to_s)
  $id = obj['id']
end

Then(/^Compare "(.*)" request with response$/) do |param|
  $request.sub! '731Z', '731+0000' if param == 'order'
  expect($response.to_s).to eq($request.to_s)
end