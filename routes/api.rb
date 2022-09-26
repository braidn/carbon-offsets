class PatchApp
  hash_branch('api') do |r|
    r.on 'offsets', Integer do |offset_id|
      offset = Offset.dataset.find(offset_id).first

      r.post 'proofs' do
        params = typecast_params.convert!(symbolize: true) do |params|
          params.float!('mass')
          params.str!('serial_number')
        end

        proof = Proof.create({ mass_g: params[:mass], serial_number: params[:serial_number], offset_id: offset.id })

        response.status = 201
        { id: proof.id, _links: { self: { href: "/api/proofs/#{proof.id}"} } }
      end
    end

    r.get 'payments' do
      payments = Order.join(:offsets, id: :offset_id)
        .join(:projects, id: :project_id)
        .select_all(:orders)
        .select_append(:project_id, Sequel.as(:name, :project_name))

      r.params['type'] == 'new' ? payments.where(captured: false) : payments.where(captured: true)

      serialized_payments = payments.all.map do |payment|
        {
          id: payment[:id],
          mass_g: payment[:mass_g],
          _embedded: { project: { id: payment[:project_id], name: payment[:project_name] } }
        }
      end

      response.status = 200
      { _embedded: { payments: serialized_payments } }
    end

    r.on 'projects', Integer do |project_id|
      project = Project.dataset.find(project_id).first

      r.post 'offsets' do
        params = typecast_params.convert!(symbolize: true) do |params|
          params.float!('mass')
          params.float!('price_in_cents')
          params.str!('currency')
        end

        price_key = "price_cents_#{params[:currency].downcase}"

        offset = Offset.create({ mass_g: params[:mass], price_key.to_sym => params[:price_in_cents], project_id: project.id })

        response.status = 201
        { data: { id: offset.id }, _links: { self: { href: "/api/projects/#{project.id}/offsets/#{offset.id}" } } }
      end

      r.get 'offsets' do
        offsets = Offset.dataset.where(project_id: project.id)

        response.status = 200
        { _embedded: { offsets: offsets.all.map(&:values) }, count: offsets.count }
      end
    end
  end
end
