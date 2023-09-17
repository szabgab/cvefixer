l = SemanticLogger["rust"]

taskgroup :rust, "upgrade various rust things" do
  describe "run rustup update", l
  task :rustup do
    sh "rustup update"
  end

  describe "update global cargo packages", l
  task :cargo do
    sh "cargo install --list | grep -E '^[[:space:]]' " \
      "| sed -E -e 's/[[:space:]]+//g' | xargs cargo install"
  end
end
