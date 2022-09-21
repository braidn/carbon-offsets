Sequel.migration do
  change do
    create_table(:orders) do
      primary_key :id
      Integer :offset_id
      Integer :mass_g
      DateTime :created_at
      DateTime :updated_at
      foreign_key [:offset_id], :offsets
    end
  end
end
