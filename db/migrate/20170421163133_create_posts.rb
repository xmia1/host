class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :name
      t.integer :blog_id
      t.string :path
      t.text :content
      t.text :header

      t.timestamps
    end
  end
end
