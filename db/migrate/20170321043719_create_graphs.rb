class CreateGraphs < ActiveRecord::Migration[5.0]
  def change
    create_table :graphs do |t|
      t.text :link

      t.timestamps
    end
  end
end
