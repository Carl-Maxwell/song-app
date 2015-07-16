class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :live_or_studio
      t.string :name

      t.timestamps null: false
    end
    add_index :albums, :band_id
  end
end
