# FILEPATH: /home/doew/dev/unleash-admin/unleash-admin/spec/unleash/admin/client_spec.rb

require 'unleash/admin/client'

RSpec.describe Unleash::Admin::Client do
  let(:config) { Unleash::Admin.configuration }
  let(:client) { Unleash::Admin::Client.new(config) }

  describe '#initialize' do
    it 'initializes with default configuration' do
      expect(client.instance_variable_get(:@config)).to eq(config)
    end
  end

  describe '#get_features' do
    it 'calls the correct API endpoint' do
      expect(client).to receive(:api_call).with(:get, "/api/admin/projects/#{config.project}/features")
      client.get_features
    end
  end

  describe '#api_call' do
    let(:url) { URI.parse(config.server_url + "/test") }
    let(:request) { instance_double(Net::HTTP::Get) }
    let(:response) { instance_double(Net::HTTPResponse, code: '200', body: '{}') }

    before do
      allow(request).to receive(:[]=)
      allow(Net::HTTP::Get).to receive(:new).and_return(request)
      allow(Net::HTTP).to receive(:start).and_yield(double.as_null_object).and_return(response)
    end

    it 'creates the correct request based on the method' do
      expect(Net::HTTP::Get).to receive(:new).with(url)
      client.api_call(:get, "/test")
    end

    it 'sets the correct headers' do
      expect(request).to receive(:[]=).with("Accept", "application/json")
      expect(request).to receive(:[]=).with("Authorization", config.admin_api_key)
      client.api_call(:get, "/test")
    end

    it 'returns the response code and parsed body' do
      expect(client.api_call(:get, "/test")).to eq(['200', {}])
    end

    context 'when the response code is 404' do
      let(:response) { instance_double(Net::HTTPResponse, code: '404') }

      it 'raises a NotFoundError' do
        expect { client.api_call(:get, "/test") }.to raise_error(Unleash::Admin::Client::NotFoundError)
      end
    end
  end
end