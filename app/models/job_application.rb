class JobApplication < ApplicationRecord
  belongs_to :user

  filterrific(
    default_filter_params: { sorted_by: 'first_contact_date_asc' },
    available_filters: %i[
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
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }



  def self.options_for_sorted_by
    [
      ['First Contact Date (newest)', 'first_contact_date_asc'],
      ['First Contact Date (oldest)', 'first_contact_date_desc'],
      ['Company Name (a-z)', 'company_name_asc'],
      ['Company Name (z-a)', 'company_name_desc']
    ]
  end
end
