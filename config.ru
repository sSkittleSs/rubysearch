# frozen_string_literal: true

require './app'
require 'redis'

run App.new(Redis.new(host: '127.0.0.1', port: 6379, db: 15, role: :master))
