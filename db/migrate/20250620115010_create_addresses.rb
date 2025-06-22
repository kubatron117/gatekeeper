class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string :street_name, limit: 100, null: false
      t.string :street_number, limit: 20, null: false
      t.string :city, limit: 100, null: false
      t.string :postal_code, limit: 20, null: false
      t.string :country_name, limit: 100, null: false

      t.timestamps
    end
  end
end
