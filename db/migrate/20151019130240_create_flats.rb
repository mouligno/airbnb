class CreateFlats < ActiveRecord::Migration
  def change
    create_table :flats do |t|
      t.integer :owner_id, index: true
      t.string :title
      t.string :address_line_1
      t.string :address_line_2
      t.string :zip_code
      t.string :city
      t.string :country
      t.integer :rooms_number
      t.integer :bed_number
      t.integer :bathroom_number
      t.integer :people_number
      t.boolean :smoker
      t.boolean :television
      t.boolean :internet
      t.string :kind

      t.timestamps null: false
    end

    add_foreign_key :flats, :users, column: :owner_id
  end
end
