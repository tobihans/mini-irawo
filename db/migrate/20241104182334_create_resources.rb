class CreateResources < ActiveRecord::Migration[7.2]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :description
      t.references :category, null: false, foreign_key: true
      t.string :kind
      t.string :uri

      t.timestamps
    end
  end
end
