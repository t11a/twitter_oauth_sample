require 'rubygems'
require 'oauth'
require 'json'

CONSUMER_KEY = 'AAAA'
CONSUMER_SECRET = 'BBBB'
ACCESS_TOKEN = 'CCCC'
ACCESS_TOKEN_SECRET = 'DDDD'

# junbi
consumer = OAuth::Consumer.new(
	CONSUMER_KEY,
	CONSUMER_SECRET,
	:site => 'http://twitter.com/'
)
access_token = OAuth::AccessToken.new(
	consumer,
	ACCESS_TOKEN,
	ACCESS_TOKEN_SECRET
)

# display user's timeline in time series
response = access_token.get('http://twitter.com/statuses/friends_timeline.json')
JSON.parse(response.body).reverse_each do |status|
	user = status['user']
	puts "#{user['name']}(#{user['screen_name']}): #{status['text']}"
end

# post a tweet
response = access_token.post(
	'http://twitter.com/statuses/update.json',
	'status' => 'This is a test tweet.'
)

puts response

