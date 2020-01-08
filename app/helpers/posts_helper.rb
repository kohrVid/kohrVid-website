require "coderay"
require "redcarpet"

module PostsHelper
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      language ||= :plaintext
      CodeRay.scan(code, language).div(css: :class)
    end
  end

  def markdown(text)
    coderayified = CodeRayify.new()

    options = {
      filter_html: false,
      hard_wrap: true,
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      tables: true,
      no_styles: false,
      tokens: true
    }

    # TODO - Not sure what this line does so may completely remove later on if
    # nothing breaks
    # style = CodeRay::Encoders[:html]::CSS.new(:default).stylesheet

    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    return markdown_to_html.render(text).html_safe
  end

  def truncate_body(rich_text_body, length = 590)
    if rich_text_body.present?
      Nokogiri::XML(
        rich_text_body.body.to_html.truncate(length+3)
      ).to_html.strip.html_safe
    end
  end
end
