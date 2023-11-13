require "formula"

class AbstractBelt < Formula
  def self.init
    homepage "https://github.com/waltzofpearls/dateparser"
    # https://github.com/syhw/homebrew/blob/master/Library/Contributions/example-formula.rb#L56-L62
    head do
      url "https://github.com/waltzofpearls/dateparser.git", :branch => "main"
      depends_on "rust" => :build
    end
    url artifact_url
    sha256 sha256sum

    test do
      system "#{bin}/belt", "--version"
    end
  end

  def self.curl_cmd
    c = 'curl -L -s'
    if ENV['HOMEBREW_GITHUB_API_TOKEN']
      c += " -H 'Authorization: token #{ENV['HOMEBREW_GITHUB_API_TOKEN']}'"
    end
    c
  end

  def self.get(url)
    JSON.parse(`#{curl_cmd} #{url}`)
  end

  def self.artifact_url
    if version.nil?
      version "latest"
    end
    version == "latest" ? latest_url : "https://github.com/waltzofpearls/dateparser/releases/download/v#{version}/belt-#{version}-macos-x86_64.zip"
  end

  def self.latest_url
    assets.select { |v| File.basename(v['browser_download_url']) =~ /#{download_file}/ }.first['browser_download_url']
  end

  def self.assets
    json = get "https://api.github.com/repos/waltzofpearls/dateparser/releases/latest"

    if json['message'] =~ /API rate limit exceeded/
      raise json['message']
    end

    if !json.key?('assets')
      raise "Could not find any assets"
    end

    json['assets']
  end

  def self.sha256sum
    if version.nil?
      version "latest"
    end

    return latest_sha256sum if version == "latest"

    `curl -L -s https://github.com/waltzofpearls/dateparser/releases/download/v#{version}/checksums.txt`.lines.grep(/#{download_file}/).first.split(' ').first
  end

  def self.latest_sha256sum
    checksum_assest = assets.select { |v| File.basename(v['browser_download_url']) =~ /checksums.txt/ }
    if checksum_assest.empty?
      raise "Could not find checksum"
    end
    url = checksum_assest.first['browser_download_url']
    `curl -L -s #{url}`.lines.grep(/#{download_file}/).first.split(' ').first
  end

  def self.download_file
    return 'belt-[0-9]\.[0-9]\.[0-9]-x86_64-unknown-linux-musl.tar.gz' if os == :linux
    'belt-[0-9]\.[0-9]\.[0-9]-macos-x86_64.zip'
  end

  def self.os
    @os ||= (
      host_os = RbConfig::CONFIG['host_os']
      case host_os
      when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
        :windows
      when /darwin|mac os/
        :macosx
      when /linux/
        :linux
      when /solaris|bsd/
        :unix
      else
        raise Error::WebDriverError, "unknown os: #{host_os.inspect}"
      end
    )
  end

  def install
    if build.head?
      system "make"
      bin.install "target/release/belt"
    else
      bin.install "belt"
    end
  end
end
