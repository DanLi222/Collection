module ApplicationHelper
  # Attach avatar for user
  def fetch_avatar(user)
    @avatar = user.avatar
    if @avatar.attached?
      @avatar
    else
      'default_avatar.gif' # When no avatar attached, display a default avatar
    end
  end
end
