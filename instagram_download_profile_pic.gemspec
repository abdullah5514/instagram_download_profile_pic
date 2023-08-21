require_relative 'lib/instagram_download_profile_pic/version'

Gem::Specification.new do |spec|
  spec.name          = "instagram_download_profile_pic"
  spec.version       = InstagramDownloadProfilePic::VERSION
  spec.authors       = ["Muhammad Abdullah"]
  spec.email         = ["mabdullah5514@yahoo.com"]

  spec.summary       = %q{Download profile pictures from Instagram user accounts with ease using the instagram_profile_pic_downloader gem.}
  spec.description   = "The instagram_profile_pic_downloader gem is a convenient and efficient tool that allows developers to easily download profile pictures from Instagram user accounts. With just a few lines of code, you can integrate this gem into your Ruby applications to fetch and save profile pictures in various formats. Whether you're building a social media analysis tool, a user profile management system, or any other application that requires access to Instagram profile images, this gem provides a seamless solution."
  spec.homepage      = "https://github.com/abdullah5514/instagram_download_profile_pic"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/abdullah5514/instagram_download_profile_pic"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end
  spec.files = Dir["lib/**/*.rb"]
  # spec.main = "lib/instagram_download_profile_pic.rb"

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
