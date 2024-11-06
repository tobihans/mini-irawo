module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_admin
    helper_method :admin?
  end

  class_methods do
    def allow_non_admin_access(**options)
      skip_before_action :require_admin, **options
    end
  end

  private

  def admin?
    Current.user&.is_admin?
  end

  def request_admin
    if !admin?
      redirect_to new_session_path, alert: t("auth.not_admin")
    end
  end
end
