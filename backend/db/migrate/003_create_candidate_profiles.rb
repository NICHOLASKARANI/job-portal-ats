class CreateCandidateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :candidate_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :full_name
      t.string :phone
      t.string :location
      t.text :skills
      t.text :experience
      t.string :resume_url
      
      t.timestamps
    end
  end
end