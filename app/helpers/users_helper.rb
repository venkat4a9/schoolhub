module UsersHelper

  def avatar_for(user, options = { class: "avatar", size: "normal" })
    case options[:size]
      when "square"
        width = 50
        height = 50
      when "normal"
        width = 100
        height = 100
      when "small"
        width = 50
        height = 50
      when "large"
        width = 200
        height = 200
    end
	  if user.provider == "facebook"
      facebook_id = user.uid
  	  image_url = "http://graph.facebook.com/#{facebook_id}/picture?height=#{height}&width=#{width}"
    else
      if user.avatar_file_name.nil?
        image_url = "default_avatar_#{options[:size]}.gif"
      else
        image_url = user.avatar(options[:size])
      end    
    end
    image_tag(image_url, alt: user.name, class: options[:class])
  end
end
