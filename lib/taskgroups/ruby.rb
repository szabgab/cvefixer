l = SemanticLogger["ruby"]

taskgroup :ruby, "upgrade various ruby things" do
  describe "update rbenv", l
  task :rbenv do
    sh "curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash"
  end
end
