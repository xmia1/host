class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.string :name
      t.string :title
      t.string :cover_image
      t.string :author_image
      t.string :author_name
      t.string :google_analytics
      t.string :url
      t.integer :user_id
      t.string :theme
      t.string :email
      t.string :description
      t.text :about
      t.string :twitter
      t.datetime :last_published_at
      t.boolean :last_published_status, :default => true

      t.timestamps
    end
  end
end
