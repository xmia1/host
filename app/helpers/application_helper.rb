module ApplicationHelper
  def resource_name
   :user
 end

 def resource_class
    User
 end

 def resource
   @resource ||= User.new
 end

 def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
 end

 def all_themes
     [
       {
       'name':'minima',
       'image':'minima.png',
       'link':'https://jekyll.github.io/minima/'
       },
       {
       'name':'kasper',
       'image':'kasper.png',
       'link':'http://rosario.io'
       }
     ]
 end
end
