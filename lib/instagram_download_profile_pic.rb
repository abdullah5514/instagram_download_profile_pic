require "instagram_download_profile_pic/version"

module InstagramDownloadProfilePic
  class Error < StandardError; end
  # Your code goes here...

  def download_instagram_profile_pic(url)
    options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
    driver = Selenium::WebDriver.for(:firefox, options: options)
    driver.get(url)

    begin
      uri = URI.parse(image_url)
      response = Net::HTTP.get_response(uri)
    
      if response.code == '200'
        File.open(download_path, 'wb') do |file|
          file.write(response.body)
        end
        puts "Image downloaded successfully to: #{download_path}"
      else
        puts "Error downloading image: #{response.message}"
      end
    rescue => e
      puts "Error downloading image: #{e.message}"
    ensure
       # Close the driver when you're done
      driver.quit if driver
    end
    


end
