class CreateDucks < ActiveRecord::Migration
  def change
    create_table :ducks do |t|
      t.integer :region
      t.text :address
      t.text :daddress
      t.string :name
      t.integer :mtype
      t.float :mlong
      t.float :mlat
      t.string :imglnk

      t.timestamps null: false
    end
  end
end
