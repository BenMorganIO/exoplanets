require ::File.expand_path('../config/environment', __FILE__)
run Rails.application

require 'rack'
require 'rack/cache'
require 'redis-rack-cache'

use Rack::Cache,
    metastore:   "#{Rails.application.secrets.redis_url}/0/metastore",
    entitystore: "#{Rails.application.secrets.redis_url}/0/entitystore"
