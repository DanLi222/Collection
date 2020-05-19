module ApplicationHelper
  def fetch_avatar(user)
    @avatar = user.avatar
    if @avatar.attached?
      @avatar
    else
      'default_avatar.gif'
    end
  end
end
