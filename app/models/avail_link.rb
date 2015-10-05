class AvailLink < ActiveRecord::Base
  self.primary_key = :linknum
  has_many :opt_links, foreign_key: :linknum

  scope :active, -> { where("rails_helper IS NOT NULL") }

  def path_helper
    "#{rails_helper}_path"
  end

  # For now, all our optional links are GETs
  def http_method
    :get
  end
end
