Sequel.migration do
  change do
    alter_table(:orders) do
      set_column_default :captured, false
    end
  end
end
