class CreateDucks < ActiveRecord::Migration
  def change
    create_table :ducks do |t|
      t.integer :region
      t.string :mtitle
      t.integer :mtype
      t.text :maddress
      t.float :mlong
      t.float :mlat
      t.string :imglnk

      t.timestamps null: false
    end
  end
end
