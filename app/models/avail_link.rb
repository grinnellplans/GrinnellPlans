class AvailLink < ActiveRecord::Base
  self.primary_key = :linknum
  has_many :opt_links, foreign_key: :linknum

  scope :active, -> { where("rails_helper IS NOT NULL") }

  def path_helper
    "#{rails_helper}_path"
  end
end

# == Schema Information
#
# Table name: avail_links
#
#  linknum   :integer         not null, primary key
#  linkname  :string(128)
#  descr     :text
#  html_code :text(255)
#  static    :text(255)
#
