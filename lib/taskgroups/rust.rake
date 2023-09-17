taskgroup :rust, "upgrade various rust things" do
  desc "run rustup update"
  task :rustup do
    sh "rustup update"
  end

  task :cargo do
    sh "cargo install --list | grep -E '^[[:space:]]' " \
      "| sed -E -e 's/[[:space:]]+//g' | xargs cargo install"
  end
end
