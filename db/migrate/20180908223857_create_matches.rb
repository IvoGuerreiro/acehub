class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :sport
      t.datetime :kickoff
      t.string :title
      t.string :competition

      t.timestamps
    end
  end
end
