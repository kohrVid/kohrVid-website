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
    options = {
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
    coderayified = CodeRayify.new(filter_html: true, hard_wrap: true)
    style = CodeRay::Encoders[:html]::CSS.new(:default).stylesheet
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    return markdown_to_html.render(text).html_safe
  end
end
