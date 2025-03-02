require "mkmf"

unless have_library("cups") && find_executable("cups-config")
  puts "Couldn't find CUPS libraries on your system. Check they're installed and in your path."
  exit
end

def cups_version
  `cups-config --version`.chomp
end

cups_cflags = `cups-config --cflags`.chomp || ""
cups_libs = `cups-config --libs`.chomp || ""

# Add additional flags for CUPS 2.x compatibility
cups_cflags += ' -DHAVE_CUPS_2_4'

with_cflags(cups_cflags) {
  with_ldflags(cups_libs) {
    create_makefile("cups")
  }
}
