# InstagramDownloadProfilePic

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/instagram_download_profile_pic`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'instagram_download_profile_pic'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install instagram_download_profile_pic

## Usage

The Instagram Profile Picture Downloader Gem provides a simple and straightforward way to download profile pictures from Instagram. Here's how you can use it:

    include InstagramDownloadProfilePic

    InstagramDownloadProfilePic::Downloader.download_instagram_profile_pic('user_name_from instgram')





## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/instagram_download_profile_pic.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
