Sequel.migration do
  change do
    create_table(:proofs) do
      primary_key :id
      String :proof_key
      Integer :mass_g
      Integer :offset_id
      DateTime :updated_at
      DateTime :created_at
      foreign_key [:offset_id], :offsets
    end
  end
end
