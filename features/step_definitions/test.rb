# require 'uri'
# require 'json'
# require 'net/http'
# require 'httparty'

# def replace_status(request, status = 'available')
#   request.sub! 'STATUS', status
# end

# def replace_id(request, id = $random)
#   request.sub! 'ID', "#{id}"
# end

# def post_method
#   uri = URI('https://petstore.swagger.io/v2/pet')
#   # request = JSON.parse '{
#   #     "id": 0,
#   #     "category": {
#   #       "id": 0,
#   #       "name": "string"
#   #     },
#   #     "name": "doggie",
#   #     "photoUrls": [
#   #       "string"
#   #     ],
#   #     "tags": [
#   #       {
#   #         "id": 0,
#   #         "name": "string"
#   #       }
#   #     ],
#   #     "status": "available"
#   #   }'

#   # request = File.read('pet.json')
#   puts '---------------------'
#   request = JSON.parse(File.read('features/step_definitions/requests/pet.json'))
#   puts '*********************'
#   request = request.to_json
#   request = replace_status(request, 'sold')
#   request = replace_id(request, '311208')
#   puts request

#   #   response = HTTParty.delete(uri)
#   response = HTTParty.post(uri, body: request.to_s, headers: { 'Content-Type' => 'application/json' })
#   puts response
# end

# post_method
