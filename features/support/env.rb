require 'uri'
require 'json'
require 'net/http'
require 'httparty'
require 'logger'


$orderReqDir = 'features/step_definitions/requests/order.json'
$petReqDir = 'features/step_definitions/requests/pet.json'
$random = Random.rand(1...10)