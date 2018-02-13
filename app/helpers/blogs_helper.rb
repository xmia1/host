module BlogsHelper
  def clean_url(url)
    regx=/:\/\//
    if regx.match(url)
      url
    else
      'http://'+url
    end
  end
end
