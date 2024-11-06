module Admin
  extend ActiveSupport::Concern

  included do
    helper_method :admin?
  end

  class_methods do
    def require_staff_role(**options)
      before_action :require_staff, **options
    end
  end

  private

  def admin?
    Current.user&.is_staff?
  end

  def require_staff
    if !admin?
      redirect_to new_session_path, alert: t("auth.not_admin")
    end
  end
end
