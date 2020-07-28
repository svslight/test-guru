module SessionsHelper
  def flash_message(name)
    if flash.any?
      content_tag :p, flash[name], class: "flash #{name}"
    end
  end  
end
