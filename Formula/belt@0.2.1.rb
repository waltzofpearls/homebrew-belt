require File.expand_path("../../Abstract/abstract_belt", __FILE__)

class BeltAT021 < AbstractBelt
  version "0.2.1"
  init
  url "https://github.com/waltzofpearls/dateparser/releases/download/v0.2.1/belt-0.2.1-macos-x86_64.zip"
  sha256 `curl -L -s https://github.com/waltzofpearls/dateparser/releases/download/v0.2.1/checksums.txt`.lines.grep(/macos-x86_64/).first.split(' ').first
end
