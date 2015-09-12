class Plan < ActiveRecord::Base
  belongs_to :account, foreign_key: :user_id
  before_save :clean_text
  after_update :set_modified_time
  alias_attribute :generated_html, :plan
  # validates_presence_of :account
  validates_length_of :plan, maximum: 16_777_215, message: 'Your plan is too long'
  validates_length_of :edit_text, maximum: 16_777_215, message: 'Your plan is too long'

  ALLOWED_HTML = {
      elements: %w[ a b hr i p span pre tt code br ],
      attributes: {
        'a' => ['href'],
        'span' => ['class'],
      },
      protocols: {
        'a' => { 'href' => %w[http https mailto] }
      },
    }

  # TODO: Consider migrating user_id to userid, like everythig else
  def userid
    user_id
  end

  def generated_html
    read_attribute(:plan).html_safe
  end

  def clean_text
    renderer = Redcarpet::Render::HTML.new hard_wrap: true, no_images: true
    markdown = Redcarpet::Markdown.new(
      renderer,
      no_intra_emphasis: true,
      strikethrough: true,
      lax_html_blocks: true,
      space_after_headers: true
    )
    plan = markdown.render edit_text

    # Convert some legacy elements
    { u: :underline, strike: :strike, s: :strike }.each do |in_class, out_class|
      pattern = Regexp.new "<#{in_class}>(.*?)<\/#{in_class}>"
      replacement = "<span class=\"#{out_class}\">\\1</span>"
      plan.gsub! pattern, replacement
    end

    # Now sanitize any bad elements
    plan_html = Sanitize.clean plan, ALLOWED_HTML

    self.generated_html = link_loves plan_html

  end

  private

    # TODO: ink_loves should be moved to a helper
  def link_loves(plan_html)
    # TODO: make actual rails links, probably in helper
    logger.debug('self.plan________' + plan_html)
    checked = {}
    loves = plan_html.scan(/\[(.*?)\]/)# get an array of everything in brackets
    loves.each do |love|
      item = love.first
      unless checked[item]
        checked[item] = true

        if item.match(/^\d+$/) && SubBoard.find(:first, conditions: { messageid: item })
          # TODO:  Regexp.escape(item, "/")
          plan_html.gsub!(/\[#{Regexp.escape(item)}\]/, "[<a href=\"board_messages.php?messagenum=$item#{item}\" class=\"boardlink\">#{item}</a>]")
          next
        end

        if item =~ /:/
          if item =~ /\|/
            # external link with name
            love_replace = item.match(/(.+?)\|(.+)/i)
            plan_html.gsub!(/\[#{Regexp.escape(item)}\]/, "<a href=\"#{love_replace[1]}\" class=\"onplan\">#{love_replace[2]}</a>")
          else
            # external link without name
            plan_html.gsub!(/\[#{Regexp.escape(item)}\]/, "<a href=\"#{item}\" class=\"onplan\">#{item}</a>")
          end
          next
        end

        account = Account.where(username: item.downcase).first
        unless account.blank?
          # change all occurences of person on plan
          plan_html.gsub!(/\[#{item}\]/, "[<a href=\"#{Rails.application.routes.url_helpers.read_plan_path account.username}\" class=\"planlove\">#{item}</a>]")
        end
      end

    end

    logger.debug('self.plan________' + plan_html)
    plan_html
  end

  def set_modified_time
    account.changed = Time.now
    account.save!
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
