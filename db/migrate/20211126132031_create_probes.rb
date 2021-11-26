class CreateProbes < ActiveRecord::Migration[6.1]
  def change
    create_table :probes, id: :uuid do |t|
      t.string :name
      t.string :cosmonaut
      t.integer :x
      t.integer :y
      t.string :direction

      t.timestamps
    end
  end
end
