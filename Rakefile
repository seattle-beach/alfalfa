namespace :sync do
  desc "Sync all configs"
  task :all do
    %w[ alfalfa bash-it pivotal_ide_prefs vim-config ].each do |repo|
      cd "~/workspace/#{repo}" do
        sh "git stash"
        sh "git pull --rebase"
        sh "git stash pop"
      end
    end
  end
end

desc "Add a config to Alfalfa"
task :add_config, [:path] do |t, args|
  path = File.expand_path(args[:path])

  from = path

  home = Dir.home
  dotfiles = File.join(File.dirname(__FILE__), "dotfiles")
  to = path.sub(home, dotfiles)

  mv from, to
  ln_s to, from
end
