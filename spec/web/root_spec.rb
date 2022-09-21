require_relative 'spec_helper'

describe '/' do
  it 'returns an empty json response' do
    response = get '/'

    _(response.status).must_equal 200
  end
end
