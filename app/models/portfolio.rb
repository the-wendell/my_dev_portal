class Portfolio < ApplicationRecord
  validates :url, presence: true,
                  length: { in: 3..30 },
                  uniqueness: true
  validates_format_of :url, with: /\A[-a-z0-9_]+\z/,
                            message: 'must only contain lowercase alphanumeric characters, hyphens, or underscores'
  validates :color_one, :color_two, :color_three, :color_four, :font_color_one, :font_color_two,
            css_hex_color: true
  validates :theme, inclusion: { in: Themes.array }
  belongs_to :user
  has_many :projects, dependent: :delete_all
  has_many :technologies, dependent: :delete_all
  has_one :portfolio_header, dependent: :delete
  has_one :about, dependent: :delete

  def render_header
    portfolio_header || filler_header
  end

  def render_projects
    projects.all.order(:order)
  end

  def render_technologies
    technologies.all
  end

  def render_about
    about || filler_about
  end

  def render_first_name
    portfolio_header ? portfolio_header.header_one.split(' ').first : ''
  end

  def render_show_technology
    if show_years_exp && show_proficiency
      'all'
    elsif show_years_exp
      'years'
    elsif show_proficiency
      'proficiency'
    else
      'none'
    end
  end

  private
  def filler_header
    PortfolioHeader.new(
      header_one: "Go back to your dashboard and create your 'Portfolio Header'",
      header_two: '',
      header_one_color: '#000000',
      header_two_color: '#000000'
    )
  end

  def filler_about
    About.new(
      about_me: "Go back to your dashboard and create your 'About Me'",
      email: '',
      github: '',
      linkedin: '',
      facebook: '',
      twitter: '',
      website: '',
      about_me_brief: ''
    )
  end
end
