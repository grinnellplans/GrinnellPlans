require 'gfm/code'

class Plan < ActiveRecord::Base
  belongs_to :account, :foreign_key=> :user_id
  before_save :clean_text
  before_update :set_modified_time

  def userid
    user_id
  end

  def clean_text
    plan = Markdown.new( gfm edit_text ).to_html
    # Convert some legacy elements
    { :u => :underline, :strike => :strike, :s => :strike }.each do |in_class,out_class|
      pattern = Regexp.new "<#{in_class}>(.*?)<\/#{in_class}>"
      replacement = "<span class=\"#{out_class}\">\\1</span>"
      plan.gsub! pattern, replacement
    end
    # Now sanitize any bad elements
    config = {}
    config[ :elements ] = %w[ a b hr i p span pre tt code br ]
    config[ :attributes ] = {
      'a' => [ 'href' ],
      'span' => [ 'class' ],
    }
    config[ :protocols ] = {
      'a' => { 'href' => [ 'http', 'https', 'mailto' ] }
    }
    self.plan = Sanitize.clean( plan, config ).strip
    # TODO make actual rails links
     checked = {}
     loves = self.plan.scan(/.*?\[(.*?)\].*?/s)#get an array of everything in brackets
    logger.debug("self.plan________"+self.plan)
     for love in loves
        debugger
       item = love.first
       jlw = item.gsub(/\#/, "\/")
       unless checked[item]
         account = Account.where(:username=>item).first
         if account.blank?
           if item.match(/^\d+$/) && SubBoard.find(:first, :conditions=>{:messageid=>item})
             #TODO  Regexp.escape(item, "/")
             self.plan.gsub!(/\[" . Regexp.escape(item) . "\]/s, "[<a href=\"board_messages.php?messagenum=$item#{item}\" class=\"boardlink\">#{item}</a>]")
           end
           if item =~ /:/
             if item =~ /|/
               love_replace = item.match(/(.+?)\|(.+)/si)
                self.plan.gsub!(/\[" . Regexp.escape(item) . "\]/s, "<a href=\"/read/#{love_replace[1]}\" class=\"onplan\">#{love_replace[2]}</a>") #change all occurences of person on plan
             else
               self.plan.gsub!(/\[" .  Regexp.escape(item) . "\]/s, "<a href=\"#{item}\" class=\"onplan\">#{item}</a>")
             end
           end
         else
           self.plan.gsub!(/\[#{item}\]/s, "[<a href=\"/read/#{item}\" class=\"planlove\">#{item}</a>]"); #change all occurences of person on plan
           
         end
       end
       checked[item]=true
     end
     logger.debug("self.plan________"+self.plan)
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

