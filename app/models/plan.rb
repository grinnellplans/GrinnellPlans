class Plan < ActiveRecord::Base
  belongs_to :account, :foreign_key=> :user_id
  before_save :clean_text
  attr_protected :generated_html
  after_update :set_modified_time
  alias_attribute :generated_html, :plan
  # validates_presence_of :account
  validates_length_of :plan, :maximum=>16777215,  :message => "Your plan is too long"
  validates_length_of :edit_text, :maximum => 16777215,  :message => "Your plan is too long"
  
  
  #TODO Consider migrating user_id to userid, like everythig else
  def userid
    user_id
  end

  def generated_html
    read_attribute( :plan ).html_safe
  end

  def clean_text
    plan = Redcarpet.new( edit_text, :hard_wrap ).to_html

    # Convert some legacy elements
    { :u => :underline, :strike => :strike, :s => :strike }.each do |in_class,out_class|
      pattern = Regexp.new "<#{in_class}>(.*?)<\/#{in_class}>"
      replacement = "<span class=\"#{out_class}\">\\1</span>"
      plan.gsub! pattern, replacement
    end

    # Now sanitize any bad elements
    self.generated_html = Sanitize.clean plan, {
      :elements => %w[ a b hr i p span pre tt code br ],
      :attributes => {
        'a' => [ 'href' ],
        'span' => [ 'class' ],
      },
      :protocols => {
        'a' => { 'href' => [ 'http', 'https', 'mailto' ] }
      },
    }

    # TODO make actual rails links
     checked = {}
     loves = self.generated_html.scan(/.*?\[(.*?)\].*?/s)#get an array of everything in brackets
    logger.debug("self.plan________"+self.generated_html)
     for love in loves
       item = love.first
       jlw = item.gsub(/\#/, "\/")
       unless checked[item]
         account = Account.where(:username=>item).first
         if account.blank?
           if item.match(/^\d+$/) && SubBoard.find(:first, :conditions=>{:messageid=>item})
             #TODO  Regexp.escape(item, "/")
             self.generated_html.gsub!(/\[" . Regexp.escape(item) . "\]/s, "[<a href=\"board_messages.php?messagenum=$item#{item}\" class=\"boardlink\">#{item}</a>]")
           end
           if item =~ /:/
             if item =~ /|/
               love_replace = item.match(/(.+?)\|(.+)/si)
                self.generated_html.gsub!(/\[" . Regexp.escape(item) . "\]/s, "<a href=\"/read/#{love_replace[1]}\" class=\"onplan\">#{love_replace[2]}</a>") #change all occurences of person on plan
             else
               self.generated_html.gsub!(/\[" .  Regexp.escape(item) . "\]/s, "<a href=\"#{item}\" class=\"onplan\">#{item}</a>")
             end
           end
         else
           self.generated_html.gsub!(/\[#{item}\]/s, "[<a href=\"/read/#{item}\" class=\"planlove\">#{item}</a>]"); #change all occurences of person on plan
           
         end
       end
       checked[item]=true
     end
     logger.debug("self.plan________"+self.generated_html)
  end
  
  private
     def set_modified_time
       self.account.changed = Time.now()
       self.account.save!
     end
end
    
# == Schema Information
#
# Table name: plans
#
#  id        :integer         not null, primary key
#  user_id   :integer(2)
#  plan      :text(16777215)
#  edit_text :text
#

