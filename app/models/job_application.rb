class JobApplication < ApplicationRecord
  belongs_to :user
  validates :company_name, :company_website, :job_location, :enthusiasm,
            :job_title, :referral, :referral_type, :status, :industry,
            length: { maximum: 100 }
  validates :notes, length: { maximum: 1000 }
  validates :job_link, length: { maximum: 250 }
  validates :enthusiasm, inclusion: { in: %w[high medium low] }
  validates :status, inclusion: { in: %w[researching applied interviewing rejected offer] }
  validates :referral_type, inclusion: { in: ['cold outreach', 'mentor', 'personal connection', 'new connection', 'career website'] }

  filterrific(
    default_filter_params: { sorted_by: 'first_contact_date_asc', asc_desc: 'asc' },
    available_filters: %i[
      asc_desc
      sorted_by
      search_query
      enthusiasm
      referral_type
      status
      time_period
      before
      after
    ]
  )

  scope :status, lambda { |param|
    where('job_applications.status = ?', param)
  }

  scope :enthusiasm, lambda { |param|
    where('job_applications.enthusiasm = ?', param)
  }

  scope :referral_type, lambda { |param|
    where('job_applications.referral_type = ?', param)
  }

  scope :time_period, lambda { |dates|
    before_and_after = dates.split(',')
    before = before_and_after.first
    after = before_and_after.last
    where('job_applications.first_contact_date >= ? AND
           job_applications.first_contact_date <= ? OR
           job_applications.first_contact_date <= ? AND
           job_applications.first_contact_date >= ?', after, before, after, before)
  }

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 6
    where(
      terms.map {
        or_clauses = [
          'LOWER(job_applications.company_name) LIKE ?',
          'LOWER(job_applications.company_website) LIKE ?',
          'LOWER(job_applications.job_location) LIKE ?',
          'LOWER(job_applications.job_title) LIKE ?',
          'LOWER(job_applications.referral) LIKE ?',
          'LOWER(job_applications.industry) LIKE ?'
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^first_contact_date_/
      order("job_applications.first_contact_date #{direction}")
    when /^company_name_/
      order("job_applications.company_name #{direction}")
    when /^job_location_/
      order("job_applications.job_location #{direction}")
    when /^job_title_/
      order("job_applications.job_title #{direction}")
    when /^referral_/
      order("job_applications.referral #{direction}")
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
      ['Job Title', 'job_title_'],
      ['Referral', 'referral_'],
      ['industry', 'industry_']
    ]
  end

  def self.options_for_asc_desc
    [
      %w[Ascending asc],
      %w[Descending desc]
    ]
  end

  def self.options_for_enthusiasm
    [
      ['- Any -', ''],
      %w[High high],
      %w[Medium medium],
      %w[Low low']
    ]
  end

  def self.options_for_referral_type
    [
      ['- Any -', ''],
      ['Cold Outreach', 'cold outreach'],
      ['Mentor', 'mentor'],
      ['Personal Connection', 'personal connection'],
      ['New Connection', 'new connection'],
      ['Career Website', 'career website']
    ]
  end

  def self.options_for_status
    [
      ['- Any -', ''],
      %w[Researching researching],
      %w[Applied applied],
      %w[Interviewing interviewing],
      %w[Rejected rejected],
      %w[Offer offer]
    ]
  end
end
