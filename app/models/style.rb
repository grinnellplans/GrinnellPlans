class Style < ActiveRecord::Base
  self.table_name = 'style'
  validates_presence_of :path
  has_many :displays, foreign_key: :style

  def descr
    # Dumb thing has HTML in it, but it's safe
    read_attribute(:descr).html_safe
  end
end
