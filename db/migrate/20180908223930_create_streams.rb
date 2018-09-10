class CreateStreams < ActiveRecord::Migration[5.2]
  def change
    create_table :streams do |t|
      t.string :url
      t.string :extra_info

      t.timestamps
    end
  end
end
