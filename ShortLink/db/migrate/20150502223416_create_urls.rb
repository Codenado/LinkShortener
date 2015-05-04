class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :description
      t.string :full_url
      t.string :short_url
      t.integer :clicks, :default => 0
      t.references :creator, index: true

      t.timestamps null: false
    end
    add_foreign_key :urls, :users
  end
end
