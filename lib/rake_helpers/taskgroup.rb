require "rake"

def taskgroup(name, description, &block)
  ns = namespace name, &block
  desc description
  task name do |task_name|
    c = task_name.name.count(":")
    ns.tasks.select { |t| c + 1 == t.name.count(":") }.each(&:invoke)
  end
end

def tasky(msg, l, *, &block)
  desc msg
  task do
    l.info msg
    task(*, &block)
  end
end
