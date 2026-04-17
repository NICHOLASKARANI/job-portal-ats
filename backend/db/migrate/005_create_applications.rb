class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.references :job, null: false, foreign_key: true
      t.references :candidate_profile, null: false, foreign_key: true
      t.text :cover_letter, null: false
      t.integer :status, default: 0
      
      t.timestamps
    end
    
    add_index :applications, [:job_id, :candidate_profile_id], unique: true
  end
end