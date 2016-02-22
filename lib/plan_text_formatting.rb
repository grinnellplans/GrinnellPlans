module PlanTextFormatting
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

  def clean_and_format(text)
    renderer = Redcarpet::Render::HTML.new hard_wrap: true, no_images: true
    markdown = Redcarpet::Markdown.new(
      renderer,
      no_intra_emphasis: true,
      strikethrough: true,
      lax_html_blocks: true,
      space_after_headers: true
    )
    plan = markdown.render text

    # Convert some legacy elements
    { u: :underline, strike: :strike, s: :strike }.each do |in_class, out_class|
      pattern = Regexp.new "<#{in_class}>(.*?)<\/#{in_class}>"
      replacement = "<span class=\"#{out_class}\">\\1</span>"
      plan.gsub! pattern, replacement
    end

    # Now sanitize any bad elements
    plan_html = Sanitize.clean plan, ALLOWED_HTML

    link_planlove plan_html
  end

  private
  def link_planlove(html)
    html = html.dup
    checked = {}
    loves = html.scan(/\[(.*?)\]/)# get an array of everything in brackets
    loves.each do |love|
      item = love.first
      unless checked[item]
        checked[item] = true

        if item =~ /:/
          if item =~ /\|/
            # external link with name
            love_replace = item.match(/(.+?)\|(.+)/i)
            html.gsub!(/\[#{Regexp.escape(item)}\]/, "<a href=\"#{love_replace[1]}\" class=\"onplan\">#{love_replace[2]}</a>")
          else
            # external link without name
            html.gsub!(/\[#{Regexp.escape(item)}\]/, "<a href=\"#{item}\" class=\"onplan\">#{item}</a>")
          end
          next
        end

        account = Account.where(username: item.downcase).first
        unless account.blank?
          # change all occurences of person on plan
          html.gsub!(/\[#{item}\]/, "[<a href=\"#{Rails.application.routes.url_helpers.read_plan_path account.username}\" class=\"planlove\">#{item}</a>]")
        end
      end

    end

    html.html_safe
  end
end
