require_relative "routes/signup"
require_relative "routes/sessions"
require_relative "routes/equipos"
require_relative "libs/mongo"
require_relative "helpers"

require "logger"
require "digest/md5"

def logger
  return Logger.new(STDOUT)
end

logger.info("Carregando arquivo spec_helper de configuracao")

def to_md5(pass)
  return Digest::MD5.hexdigest(pass)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.before(:suite) do
    users = [
      { name: "andso", email: "andso4@teste.com.br", password: to_md5("1234") },
    ]
  end
end
