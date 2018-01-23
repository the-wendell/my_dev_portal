class MaxProjectsValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless Portfolio.find(value).projects.count < 10
      object.errors[attribute] << (options[:message] || 'You have reached the maximum number of allowed projects for this portfolio')
    end
  end
end
