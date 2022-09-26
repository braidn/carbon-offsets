Sequel.migration do
  change do
    alter_table(:offsets) do
      set_column_default :retired, false
    end
  end
end
