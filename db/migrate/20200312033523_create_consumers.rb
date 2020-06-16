class CreateConsumers < ActiveRecord::Migration[5.2]
  def change
    create_table :consumers do |t|
      t.string :description
      t.string :author
      t.string :token

      t.timestamps
    end
  end
end
