json.extract! job_application, :id, :first_contact_date, :company_name, :company_website, :job_location, :enthusiasm, :job_title, :job_link, :referral, :referral_type, :status, :industry, :notes, :created_at, :updated_at
json.url job_application_url(job_application, format: :json)
