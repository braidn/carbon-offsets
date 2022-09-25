Sequel.migration do
  change do
    alter_table(:orders) do
      add_column :captured, FalseClass
    end
  end
end
