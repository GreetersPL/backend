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
    stub_request(:any, /api.trello*/)
      .with(headers: { 'Accept' => '*/*; q=0.5, application/xml', 'Content-Type' => 'application/x-www-form-urlencoded' })
      .to_return(status: 200, body: '{"id":"4f0cb2bbb5c4dc8c7800006b","name":"Hello World","desc":"Test Card","closed":false,"idList":"4f04af2120332fdd0c00007c","idBoard":"4f04af2120332fdd0c000078","idMembers":[],"url":"http://trello-dev:9000/card/board/hello-world/4f04af2120332fdd0c000078/4f0cb2bbb5c4dc8c7800006b", "shortLink":"test" ,"checkItemStates":[],"badges":{"votes":0,"fogbugz":"","checkItems":0,"checkItemsChecked":0,"comments":0,"attachments":0,"description":false,"due":null},"labels":[]}', headers: {})
  end

  config.order = :random
end

WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')
