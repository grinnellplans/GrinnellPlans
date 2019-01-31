class Style < ActiveRecord::Base
  self.table_name = 'style'
  validates_presence_of :path
  validate :path_is_css

  has_many :displays, foreign_key: :style

  def descr
    # Dumb thing has HTML in it, but it's safe
    read_attribute(:descr).html_safe
  end

  private
  def path_is_css
      if path && !path.end_with?('.css')
        errors.add(:path, 'file must be CSS')
      end
  end
end
