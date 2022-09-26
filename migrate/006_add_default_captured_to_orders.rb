Sequel.migration do
  def up
    alter_table(:orders) do
      set_column_default :captured, false
    end
  end

  def down; end
end
