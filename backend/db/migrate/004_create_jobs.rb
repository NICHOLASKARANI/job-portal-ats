class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.references :employer_profile, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.text :requirements, null: false
      t.string :location, null: false
      t.string :salary_range
      t.integer :employment_type, default: 0
      t.date :expiry_date
      t.integer :status, default: 1
      
      t.timestamps
    end
    
    add_index :jobs, :title
    add_index :jobs, :location
    add_index :jobs, :status
  end
end