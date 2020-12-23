class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ""
      t.string :image
      t.string :address
      t.text :description, null: false
      t.string :site_url

      t.timestamps
    end
  end
end
