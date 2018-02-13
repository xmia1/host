namespace :git do
  desc "TODO"
  task init: :environment do
    `git config --global user.name projectlkp && git config --global user.email projectlkopo@gmail.com`
    `cd && touch .netrc`
    `chmod 600 .netrc`
    File.write(".netrc",
        <<-HEREDOC
machine github.com
login projectlkp
password #{ENV['github_pwd']}
    HEREDOC
        )
  end
end
