class CreateProbes < ActiveRecord::Migration[6.1]
  def change
    create_table :probes, id: :uuid do |t|
      t.string :name
      t.string :cosmonaut
      t.integer :x, default: 0
      t.integer :y, default: 0
      t.string :direction, default: 'C'

      t.timestamps
    end
  end
end
