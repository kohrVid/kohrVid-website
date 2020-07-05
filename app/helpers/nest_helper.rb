module NestHelper
  def admin_is_logged_in
    @admin_is_logged_in = current_user && current_user.admin?
  end

  def current_user?(user)
    user == current_user
  end

  def current_user_id?(user_id)
    user_id == current_user.id
  end

  def redirect_to_login
    unless user_signed_in?
      flash[:error] = "Please log in"
      redirect_to login_path
    end
  end

  def admin_user_404
    unless current_user && current_user.admin?
      raise ActionController::RoutingError.new('Not Found')
      #render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
    end
  end

  def meta_keywords
    main_keywords = %w(kohrVid Jessica Ete Developer Rubyist Scala Go)
    main_keywords += @post.tag_names if @post.present?

    main_keywords.uniq(&:downcase).join(",")
  end

  def list_current_errors
    instance_variables.select do |ivar|
      instance_variable_get(ivar).respond_to?(:errors)
    end.map do |model|
      instance_variable_get(model).errors.try(:full_messages)
    end.flatten
  end

=begin
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
=end
end
