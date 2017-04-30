require "coderay"
require "redcarpet"
module PostsHelper
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      language ||= :plaintext
      CodeRay.scan(code, language).div(line_numbers: :table, css: :class)
    end
  end

  def markdown(text)
    coderayified = CodeRayify.new(filter_html: true, hard_wrap: true)
    options = {
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      lax_html_blocks: true,
      strikethrough:      true,
      superscript:        true,
      tables: true,
      no_styles: false,
      tokens: true
    }
    style = CodeRay::Encoders[:html]::CSS.new(:default).stylesheet
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    return markdown_to_html.render(text).html_safe
  end
end
