module ApplicationHelper
  def gravatar_for(user, options = { size: 80 })
    email = user.email.downcase
    hash = Digest::MD5.hexdigest(email)
    size = options[:size]
    image_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"

    image_tag(image_url, alt: user.username, class: "shadow-sm rounded-circle mx-auto d-block")
  end
end
