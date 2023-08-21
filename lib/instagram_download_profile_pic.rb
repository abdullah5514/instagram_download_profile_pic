require 'selenium-webdriver'
require 'net/http'

module InstagramDownloadProfilePic
  class Error < StandardError; end

  class Downloader
    def self.download_instagram_profile_pic(url)
      if firefox_driver_available?
        puts 'Firefox WebDriver is available on the system.'
        options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
        driver = Selenium::WebDriver.for(:firefox, options: options)
        driver.get(url)
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        
        begin
          element = wait.until { driver.find_element(:xpath, '//img[contains(@alt, "profile picture")]') }
          src_attribute = element.attribute('src')

          if src_attribute
            download_image(src_attribute)
          else
            puts 'Image source attribute not found.'
          end
        rescue Selenium::WebDriver::Error::TimeoutError
          puts 'Timeout: Profile picture element not found.'
        end

        driver.quit
      else
        puts 'Firefox WebDriver is not available on the system.'
      end
    end

    def self.download_image(url)
      uri = URI.parse(url)
      image_data = Net::HTTP.get_response(uri).body
      image_filename = 'profile_picture.jpg' # Change this to your desired filename

      File.open(image_filename, 'wb') do |file|
        file.write(image_data)
      end

      puts "Image downloaded as '#{image_filename}'"
    end

    def self.firefox_driver_available?
      `geckodriver --version`
      $?.success?
    end
  end
end
