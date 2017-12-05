class CreateImportRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :import_requests do |t|

      t.string :type, :null => false
      t.integer :import_id, :default => 0

      t.string :state

      t.integer :total_count, :default => 0
      t.integer :succeeded_count, :default => 0
      t.integer :failed_count, :default => 0

      t.text :exception

      t.timestamp
    end
    add_index :import_requests, [:type]
  end
end
