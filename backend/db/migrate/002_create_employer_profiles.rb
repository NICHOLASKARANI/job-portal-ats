class CreateEmployerProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :employer_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name
      t.string :company_logo
      t.text :company_description
      t.string :website
      
      t.timestamps
    end
  end
end