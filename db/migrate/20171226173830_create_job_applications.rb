class CreateJobApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :job_applications do |t|
      t.references :user, foreign_key: true
      t.date :first_contact_date
      t.string :company_name
      t.string :company_website
      t.string :job_location
      t.string :enthusiasm
      t.string :job_title
      t.string :job_link
      t.string :referral
      t.string :referral_type
      t.string :status
      t.string :industry
      t.text :notes

      t.timestamps
    end
  end
end
