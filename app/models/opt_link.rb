class OptLink < ActiveRecord::Base
  belongs_to :account, :foreign_key=> :userid
  belongs_to :avail_link, :foreign_key=>:linknum
end

# == Schema Information
#
# Table name: opt_links
#
#  userid  :integer(2)      default(0), not null
#  linknum :integer(1)
#

