class DisplayPreference < ActiveRecord::Base
  self.table_name = 'display'
  self.primary_key = :userid
  belongs_to :interface, foreign_key: :interface
  belongs_to :account, foreign_key: :userid
  belongs_to :style, foreign_key: :style

  def style_id
    read_attribute_before_type_cast :style
  end
end
