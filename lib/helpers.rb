
def command?(name)
    system "command", "-v", name,  :out => File::NULL
    $?.success?
end