class CreateFlatPictures < ActiveRecord::Migration
  def change
    create_table :flat_pictures do |t|
      t.references :flat, index: true, foreign_key: true
      t.string :image

      t.timestamps null: false
    end
  end
end
