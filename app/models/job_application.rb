class JobApplication < ApplicationRecord
  belongs_to :user
  attr_accessor :direction

  filterrific(
    default_filter_params: { sorted_by: 'first_contact_date_asc', asc_desc: 'asc' },
    available_filters: %i[
      asc_desc
      sorted_by
      search_query
    ]
  )

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^first_contact_date_/
      order("job_applications.first_contact_date #{direction}")
    when /^company_name_/
      order("job_applications.company_name #{direction}")
    when /^job_location_/
      order("job_applications.job_location #{direction}")
    when /^enthusiasm_/
      order("job_applications.enthusiasm #{direction}")
    when /^job_title_/
      order("job_applications.job_title #{direction}")
    when /^referral_/
      order("job_applications.referral #{direction}")
    when /^referral_type_/
      order("job_applications.referral_type #{direction}")
    when /^status_/
      order("job_applications.status #{direction}")
    when /^industry_/
      order("job_applications.industry #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  def self.options_for_sorted_by
    [
      ['First Contact Date', 'first_contact_date_'],
      ['Company Name', 'company_name_'],
      ['Job Location', 'job_location_'],
      ['Enthusiasm', 'enthusiasm_'],
      ['Job Title', 'job_title_'],
      ['Referral', 'referral_'],
      ['Referral Type', 'referral_type_'],
      ['Status', 'status_'],
      ['industry', 'industry_']
    ]
  end

  def self.options_for_asc_desc
    [
      ['Ascending', 'asc'],
      ['Descending', 'desc']
    ]
  end

end
