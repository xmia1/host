module PostsHelper
  def file_path(name)
    Time.now.strftime("%Y-%m-%d")+'-'+name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')+'.markdown'
  end
  def post_header(name)
    <<-HEREDOC
---
layout: post
title:  #{name.capitalize.gsub!(/[^0-9A-Za-z]/, ' ')}
date:   #{Time.now}
---
    HEREDOC
  end
end
