require_relative 'spec_helper'

describe '/api' do
  before :all do
    @project = Project.create( name: "Forestry" )
  end
  
  describe '#POST projects/1/offsets adds offset inventory to a given project' do
    let(:params) { { mass: 100340, price_in_cents: 2500000.0, currency: 'usd' } }

    it 'returns a created status code' do
      response = post "api/projects/#{@project.id}/offsets", params

      _(response.status).must_equal 201
    end

    it 'returns the id of the newly created resource' do
      response = post "api/projects/#{@project.id}/offsets", params
      new_offset = Offset.dataset.last

      _(JSON.parse(response.body, symbolize_names: true)[:data]).must_equal( { id: new_offset.id } )
    end

    it 'returns a URL to be able to re-request the details of the new offset' do
      response = post "api/projects/#{@project.id}/offsets", params

      new_offset = Offset.dataset.last

      _(JSON.parse(response.body, symbolize_names: true)[:_links]).must_equal( { self: { href: "/api/projects/#{@project.id}/offsets/#{new_offset.id}"} } )
    end
  end
end
