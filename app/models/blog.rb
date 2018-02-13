class Blog < ApplicationRecord
  has_many :posts, :dependent => :destroy
  belongs_to :user

  def publish
    begin
      self.clean_folder()
      self.create_folder()
      self.update_config()
      self.update_about()
      self.update_cname()
      self.update_posts()
      self.deploy_github()
      self.clean_folder()
      self.last_published_at=Time.now
      self.last_published_status=true
    rescue
      self.last_published_at=Time.now
      self.last_published_status=false
    end
    self.save!
  end

  def path()
    "all_projects/#{self.name}_#{self.theme}"
  end

  def clean_folder()
    `rm -rf #{self.path}`
  end

  def create_folder()
    `cp -R themes/#{self.theme} #{self.path}`
  end

  def update_cname()
    if self.url!="#{Rails.configuration.lkp['base_url']}/#{self.name}/"
     File.write("#{self.path}/CNAME",
      self.url.chomp("/")
     )
    else
     File.write("#{self.path}/CNAME",
      ""
     )
    end
  end

  def get_baseurl()
    if self.url=="#{Rails.configuration.lkp['base_url']}/#{self.name}/"
      "/#{self.name}"
    elsif self.url=="#{Rails.configuration.lkp['base_url']}/#{self.name}"
      "/#{self.name}"
    else
      "/"
    end
  end

  def update_config()
      File.write("#{self.path}/_config.yml",
      <<-HEREDOC
title: #{self.title || Rails.configuration.lkp['default_name']}
email: #{self.email || Rails.configuration.lkp['default_email']}
description: > # this means to ignore newlines until "baseurl:"
 #{self.description.gsub(/\n/, " ").strip()}

baseurl: "/" # the subpath of your site, e.g. /blog
url: "#{self.url.chomp("/")}" # the base hostname & protocol for your site
twitter_username: #{self.twitter || Rails.configuration.lkp['default_twitter']}

markdown: kramdown

name: #{self.title || Rails.configuration.lkp['default_name']}

date: #{Time.now}
permalink: /:year/:month/:day/:title

logo: false
paginate: 10
adsid: ca-pub-8582082279264878
domain_name: #{self.url}
google_analytics: #{self.google_analytics}
gems: [jekyll-paginate]
cover: #{self.cover_image}
author_image: #{self.author_image}
# Details for the RSS feed generator
author:        #{self.author_name}
      HEREDOC
      )
  end

  def update_about()
      File.write("#{self.path}/about.md",
      <<-HEREDOC
---
layout: page
title: About
permalink: /about/
---

#{self.about || Rails.configuration.lkp['default_about']}
      HEREDOC
      )
  end

  def update_posts()
    for post in self.posts.where("mark_work_in_progress IS NULL OR mark_work_in_progress = ?", false) do
      File.write("#{self.path}/_posts/#{post.path}", post.header+"\n"+"\n"+post.content)
    end
  end

  def deploy_github()
    `cd #{self.path} && git init && git add --all && git checkout -b #{Rails.configuration.lkp['branch']} && git commit -m "first commit" && git remote add origin https://github.com/#{Rails.configuration.lkp['gitusername']}/#{self.user.username} && git push -f origin #{Rails.configuration.lkp['branch']}`
  end
end
