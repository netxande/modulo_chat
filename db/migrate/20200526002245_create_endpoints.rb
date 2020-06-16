class CreateEndpoints < ActiveRecord::Migration[5.2]
  def change
    create_table :endpoints do |t|
      t.string :titulo
      t.string :url
      t.string :method
      t.string :color
      t.string :description
      t.string :payload
      t.string :response
      t.references :news, foreign_key: true

      t.timestamps
    end
  end
end
