class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :query
      t.string :ip_address

      t.timestamps
    end
  end
end
