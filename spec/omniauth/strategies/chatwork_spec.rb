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
    it 'should use name, image, email, nickname from raw_info' do
      allow(subject).to receive(:raw_info).and_return({ 'name' => 'lastname.firstname', 'avatar_image_url' => 'http://example.com/image.png', 'login_mail' => 'hoge@example.com', 'chatwork_id' => 'me' })
      expect(subject.info[:name]).to eq 'lastname.firstname'
      expect(subject.info[:image]).to eq 'http://example.com/image.png'
      expect(subject.info[:email]).to eq 'hoge@example.com'
      expect(subject.info[:nickname]).to eq 'me'
    end
  end

  context '#extra' do
    it 'should use raw_info' do
      allow(subject).to receive(:raw_info).and_return({})
      expect(subject.extra[:raw_info]).to eq({})
    end
  end

  context '#raw_info' do
    it 'should use me api' do
      expect(access_token).to receive(:get).with('/v2/me').and_return(response)
      expect(subject.raw_info).to eq parsed_response
    end
  end
end
