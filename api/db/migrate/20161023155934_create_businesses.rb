class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :image
      t.text :description
      t.string :website
      t.string :facebook_page
      t.string :contact_number
      t.string :location
      t.string :services, array: true
      t.boolean :published, default: false

      t.timestamps
    end
    add_index :businesses, :services, using: 'gin'
  end
end
