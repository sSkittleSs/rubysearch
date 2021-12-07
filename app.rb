# frozen_string_literal: true

require 'hobbit'

module Pages
  def index_html
    index_set_html << index_get_html
  end

  def index_set_html
    '<h2>Set</h2>' \
      '<hr>' \
      '<form action="/set/" accept-charset="UTF-8" method="post">' \
      '<input placeholder="Key" type="text" value="" name="key" id="key">' \
      '<input placeholder="Value" type="text" value="" name="value" id="value">' \
      '<input type="submit" value="Update review">' \
      '</form>' \
      '<hr>'
  end

  def index_get_html
    '<h2>Get</h2>' \
      '<hr>' \
      '<form action="/get/" accept-charset="UTF-8" method="get">' \
      '<input placeholder="Key" type="text" value="" name="key" id="key">' \
      '<input type="submit" value="Update review">' \
      '</form>'
  end

  def get_html(key, value)
    value ? "<br><hr>Key: #{key} | Val: #{value}<br><hr>" : "<h1>No values for key '#{key}'</h1>"
  end
end

class App < Hobbit::Base
  include Pages

  def initialize(redis)
    @redis = redis
  end

  get '/' do
    index_html
  end

  post '/set/' do
    @redis.set(request.params['key'], request.params['value'])
    response.status = 201
  end

  get '/get/' do
    get_html(request.params['key'], @redis.get(request.params['key']))
  end
end
