require "instagram_download_profile_pic/version"

module InstagramDownloadProfilePic
  class Error < StandardError; end
  # Your code goes here...

  def download_instagram_profile_pic(url)
    options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
    driver = Selenium::WebDriver.for(:firefox, options: options)
    driver.get(url)
    image_url = driver.find_element(:css, '.x1lliihq img').attribute('src')



    if image_url
      uri = URI.parse(src_attribute)
      image_data = Net::HTTP.get_response(uri).body
      image_filename = 'profile_picture.jpg' # Change this to your desired filename
    
      # Save the image to the local directory
      File.open(image_filename, 'wb') do |file|
        file.write(image_data)
      end
    
      puts "Image downloaded as '#{image_filename}'"
    else
      puts "Image source attribute not found."
    end
    
    driver.quit
  end
end
