module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    messages = resource.errors.full_messages.map do |msg|
      content_tag(:li, msg)
    end.join
    sentence = I18n.t(
      "errors.messages.not_saved",
      :count => resource.errors.count,
      :resource => resource.class.model_name.human.downcase
    )

    html = <<-HTML
    <div id="error_explanation" class = "alerts">
      <div class = "error">
        <a href = "#" class = "close">&times;</a>
        <h4>#{ sentence }</h4>
        <ul>#{ messages }</ul>
      </div>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end
  
  #Devise Helpers
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
