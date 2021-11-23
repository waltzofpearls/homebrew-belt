require File.expand_path("../../Abstract/abstract_belt", __FILE__)

class BeltAT014 < AbstractBelt
  version "0.1.4"
  init
  url "https://github.com/waltzofpearls/belt/releases/download/v0.1.4/belt-0.1.4-x86_64-apple-darwin.tar.gz"
  sha256 `curl -L -s https://github.com/waltzofpearls/belt/releases/download/v0.1.4/belt-0.1.4-checksums.txt`.lines.grep(/x86_64-apple-darwin/).first.split(' ').first
end
