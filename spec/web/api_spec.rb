require_relative 'spec_helper'

describe '/api' do
  before :all do
    @project = Project.create( name: "Forestry" )
    @offset = Offset.create({ mass_g: 100000, price_cents_usd: 3000.0, project_id: @project.id })
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

  describe '#GET projects/1/offsets returns a list of offsets for the project' do
    it 'returns a 200 status code' do
      response = get "api/projects/#{@project.id}/offsets" 

      _(response.status).must_equal 200
    end

    it 'returns a list of offsets for the project' do
      response = get "api/projects/#{@project.id}/offsets" 

      _(JSON.parse(response.body, symbolize_names: true)[:_embedded][:offsets]).must_equal([
        @offset.values
      ])
    end

    it 'returns a count of the total offsets' do
      response = get "api/projects/#{@project.id}/offsets" 

      _(JSON.parse(response.body, symbolize_names: true)[:count]).must_equal( Offset.dataset.all.count )
    end
  end

  describe '#POST offsets/1/proofs adds a proof to an offset' do
    let(:params) { { mass: 100340, serial_number: "123MEPLS" } }

    it 'returns a created status code' do
      response = post "api/offsets/#{@offset.id}/proofs", params

      _(response.status).must_equal 201
    end

    it 'returns the id of the newly created resource' do
      response = post "api/offsets/#{@offset.id}/proofs", params

      new_proof = Proof.dataset.last

      _(JSON.parse(response.body, symbolize_names: true)[:id]).must_equal( new_proof.id )
    end

    it 'returns a URL to be able to re-request the details of the new offset' do
      response = post "api/offsets/#{@offset.id}/proofs", params

      new_proof = Proof.dataset.last

      _(JSON.parse(response.body, symbolize_names: true)[:_links]).must_equal( { self: { href: "/api/proofs/#{new_proof.id}"} } )
    end
  end
end
