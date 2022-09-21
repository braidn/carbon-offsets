Sequel.migration do
  change do
    create_table(:offsets) do
      primary_key :id
      Integer :project_id
      Integer :mass_g
      Float :price_cents_usd
      FalseClass :retired
      DateTime :created_at
      DateTime :updated_at
      foreign_key [:project_id], :projects
    end
  end
end
