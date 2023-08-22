require 'selenium-webdriver'
require 'net/http'
require 'uri'
require 'fileutils'

module InstagramDownloadProfilePic
  class Error < StandardError; end

  class Downloader
    TMP_FOLDER =  File.join(Dir.pwd, 'tmp', 'profile_pics')

    def self.download_instagram_profile_pic(url)
      case
      when !valid_instagram_url?(url)
        puts 'Invalid URL format. Please provide a valid Instagram profile URL.'
      when !firefox_driver_available?
        puts 'Firefox WebDriver is not available on the system.'
      else
        create_tmp_folder unless File.directory?(TMP_FOLDER)
        puts 'Firefox WebDriver is available on the system.'
        options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
        driver = Selenium::WebDriver.for(:firefox, options: options)
        driver.get(url)
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        
        begin
          element = wait.until { driver.find_element(:xpath, '//img[contains(@alt, "profile picture")]') }
          src_attribute = element.attribute('src')
          alt_text = element.attribute('alt')

          if src_attribute
            download_image(src_attribute, alt_text)
          else
            puts 'Image source attribute not found.'
          end
        rescue Selenium::WebDriver::Error::TimeoutError
          puts 'Timeout: Profile picture element not found.'
        end

        driver.quit
      end
    end

    def self.download_image(url, alt_text)
      uri = URI.parse(url)
      image_data = Net::HTTP.get_response(uri).body
      image_filename = generate_filename(alt_text)
      image_path = File.join(TMP_FOLDER, image_filename)

      File.open(image_path, 'wb') do |file|
        file.write(image_data)
      end

      puts "Image downloaded as '#{image_path}'"
    end

    def self.valid_instagram_url?(url)
      url.match?(%r{^https://www\.instagram\.com/[\w_]+/$})
    end

    def self.firefox_driver_available?
      `geckodriver --version`
      $?.success?
    end

    def self.generate_filename(alt_text)
      sanitized_alt_text = alt_text.gsub(/[^0-9A-Za-z]/, '_') # Remove special characters from alt text
      "profile_pic_#{sanitized_alt_text}.jpg"
    end

    def self.create_tmp_folder
      begin
        FileUtils.mkdir_p(TMP_FOLDER)
        puts "Temporary folder '#{TMP_FOLDER}' created."
      rescue Errno::EACCES => e
        puts "Error creating temporary folder: #{e.message}"
      end
    end
  end
end
