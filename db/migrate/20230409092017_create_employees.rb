class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.integer :identification_number, null: false, index: { unique: true }
      t.string :full_name
      t.timestamps
    end
  end
end
