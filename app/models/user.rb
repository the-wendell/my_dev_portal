class User < ApplicationRecord
  has_many :portfolios
  include Gravtastic
  gravtastic size: 60, filetype: 'gif'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
