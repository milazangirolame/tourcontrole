class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def to_slug
    name.parameterize.truncate(80, omission: '').concat("--#{id.to_s}")
  end

end
