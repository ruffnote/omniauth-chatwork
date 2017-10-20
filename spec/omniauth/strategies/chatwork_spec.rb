require 'spec_helper'

RSpec.describe OmniAuth::Strategies::ChatWork do
  let(:access_token) { instance_double('AccessToken', options: {}) }
  let(:parsed_response) { instance_double('ParsedResponse') }
  let(:response) { instance_double('Response', parsed: parsed_response) }

  let(:local_site) { 'https://localhost' }
  let(:local_authorize_url) { 'https://localhost/oauth/authorize' }
  let(:local_token_url) { 'https://localhost/oauth/token' }
  let(:local) do
    OmniAuth::Strategies::ChatWork.new(
      'CHATWORK_ID', 'CHATWORK_SECRET', {
        client_options: {
          site: local_site,
          authorize_url: local_authorize_url,
          token_url: local_token_url
        }
      }
    )
  end

  subject do
    OmniAuth::Strategies::ChatWork.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context 'client_options' do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq 'https://api.chatwork.com'
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq 'https://www.chatwork.com/packages/oauth2/login.php'
    end

    it 'should have correct correct token url' do
      expect(subject.options.client_options.token_url).to eq 'https://oauth.chatwork.com/token'
    end

    describe 'should be overrideable' do
      it 'for site' do
        expect(local.options.client_options.site).to eq local_site
      end

      it 'for authorize url' do
        expect(local.options.client_options.authorize_url).to eq local_authorize_url
      end

      it 'for token url' do
        expect(local.options.client_options.token_url).to eq local_token_url
      end
    end
  end

  context '#info' do
    pending 'should use nickname, image rom raw_info'
  end

  context '#extra' do
    pending 'should use raw_info'
  end

  context '#raw_info' do
    pending 'should use me api'
  end
end
