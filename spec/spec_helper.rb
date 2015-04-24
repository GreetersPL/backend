require 'webmock/rspec'

# http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    stub_request(:any, /api.hipchat*/)
      .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })
      .to_return(status: 200, body: '', headers: {})
  end

  config.order = :random
end

WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')
