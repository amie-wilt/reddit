class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author_name
      t.string :author_email
      t.text :body
      t.references :bookmark

      t.timestamps null: false
    end
  end
end
