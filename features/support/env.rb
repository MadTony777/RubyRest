require 'uri'
require 'json'
require 'net/http'
require 'httparty'
require 'logger'

$response = ''
$id = ''
$status = 'available'
$statuses = ['available', 'pending', 'sold']
$random = Random.rand(1...10)
$logger = Logger.new('my_logs.log')