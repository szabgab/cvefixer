taskgroup :ruby, "upgrade various ruby things" do
  desc "update rbenv"
  task :rbenv do
    sh "curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash"
  end
end
