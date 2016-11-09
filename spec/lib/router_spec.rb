RSpec.describe do
  subject do
    Router.new do
      get '/test', ->(env) { [200, {}, ['get test']] }
      post '/test', ->(env) { [201, {}, ['post test']] }
    end
  end

  context 'when request is GET' do
    let(:env) { { 'REQUEST_PATH' => '/test', 'REQUEST_METHOD' => 'GET' } }

    it 'matches request' do
      # p subject  # to debug
      expect(subject.call(env)).to eq [200, {}, ['get test']]
    end
  end

  context 'when request is POST' do
    let(:env) { { 'REQUEST_PATH' => '/test', 'REQUEST_METHOD' => 'POST' } }

    it 'matches request' do
      expect(subject.call(env)).to eq [201, {}, ['post test']]
    end
  end
end