require File.expand_path("../../Abstract/abstract_belt", __FILE__)

class BeltAT010 < AbstractBelt
  version "0.1.2"
  init
  url "https://github.com/waltzofpearls/belt/releases/download/v0.1.2/belt-0.1.2-x86_64-apple-darwin.tar.gz"
  sha256 `curl -L -s https://github.com/waltzofpearls/belt/releases/download/v0.1.2/belt-0.1.2-checksums.txt`.lines.grep(/x86_64-apple-darwin/).first.split(' ').first
end
