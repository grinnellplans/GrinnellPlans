class Plan < ActiveRecord::Base
  belongs_to :account, :foreign_key=> :user_id
  before_save :clean_text
  before_update :set_modified_time

  def userid
    user_id
  end
  
  # TODO make actual rails links
  # this is by no means finished or tested
  def clean_text
     checked = {}
     self.plan= CGI.escapeHTML(edit_text) #take out html
     # escape all html but <b><tt><pre><s><i><u><a href="">
     self.plan.gsub!(/((\[\w*\],?){8})(?=[^ ,])/s, "$1 ")
     self.plan.gsub!(/\n/s, "<br>")
     self.plan.gsub!(/\&lt\;hr\&gt\;/si, "</p><hr><p class=\"sub\">")
     # replace the first </p> that we just inserted erroneously
     self.plan = '<p class="sub">'+self.plan+'</p>';
     self.plan.gsub!(/\&lt\;b\&gt\;(.*?)\&lt\;\/b\&gt\;/si, "<b>\\1</b>") #allow stuff in the bold tag back in
     self.plan.gsub!(/\&lt\;tt\&gt\;(.*?)\&lt\;\/tt\&gt\;/si, "<tt>\\1</tt>")
     self.plan.gsub!(/\&lt\;pre\&gt\;(.*?)\&lt\;\/pre\&gt\;/si, "</p><pre class=\"sub\">\\1</pre><p class=\"sub\">")
     self.plan.gsub!(/\&lt\;strike\&gt\;(.*?)\&lt\;\/strike\&gt\;/si, "<span class=\"strike\">\\1</span><!--strike-->")
     self.plan.gsub!(/\&lt\;s\&gt\;(.*?)\&lt\;\/s\&gt\;/si, "<s>\\1</s>")
     self.plan.gsub!(/\&lt\;i\&gt\;(.*?)\&lt\;\/i\&gt\;/si, "<i>\\1</i>") #allow stuff in the italics tag back in
     self.plan.gsub!(/\&lt\;u\&gt\;(.*?)\&lt\;\/u\&gt\;/si, "<span class=\"underline\">\\1</span><!--u-->") #allow stuff in the underline tag back in
     self.plan.gsub!(/\&lt\;a.+?href=.&quot\;(.+?).&quot\;&gt\;(.+?)&lt\;\/a&gt\;/si, "<a href=\"\\1\" class=\"onplan\">\\2</a>")
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

