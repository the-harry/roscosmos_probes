class ChangeProbeDefaultDirection < ActiveRecord::Migration[6.1]
  def up
    change_column_default :probes, :direction, 'D'
  end

  def down
    change_column_default :probes, :direction, 'C'
  end
end
