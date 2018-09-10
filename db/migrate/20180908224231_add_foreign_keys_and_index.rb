class AddForeignKeysAndIndex < ActiveRecord::Migration[5.2]
  def change
    add_column :streams, :match_id, :integer
    add_index :streams, :match_id
    add_index :matches, :kickoff
  end
end
