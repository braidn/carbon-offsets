Sequel.migration do
  def up
    alter_table(:offsets) do
      set_column_default :retired, false
    end
  end

  def down; end
end
