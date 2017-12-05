class AddCreatedAtToImportRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :import_requests, :created_at, :datetime
  end
end
