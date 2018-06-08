class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def to_slug
    "#{id.to_s}--".concat(name.parameterize.truncate(80, omission: ''))
  end

end
