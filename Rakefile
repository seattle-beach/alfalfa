namespace :sync do
  desc 'Sync all configs'
  task :all do
    %w[ alfalfa bash-it pivotal_ide_prefs vim-config ].each do |repo|
      cd "~/workspace/#{repo}" do
        sh 'git stash'
        sh 'git pull --rebase'
        sh 'git stash pop'
      end
    end
  end
end
