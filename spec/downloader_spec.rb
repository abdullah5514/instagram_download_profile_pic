require 'spec_helper'
require 'instagram_download_profile_pic'

RSpec.describe InstagramDownloadProfilePic::Downloader do
  describe '.valid_instagram_url?' do
    it 'returns true for a valid Instagram URL' do
      expect(described_class.valid_instagram_url?('https://www.instagram.com/valid_user/')).to be(true)
    end

    it 'returns false for an invalid Instagram URL' do
      expect(described_class.valid_instagram_url?('https://example.com')).to be(false)
    end
  end

  describe '.generate_filename' do
    it 'generates a valid filename from alt text' do
      alt_text = "swati_jain_show_day's profile picture"
      expected_filename = 'profile_pic_swati_jain_show_day_s_profile_picture.jpg'
      expect(described_class.generate_filename(alt_text)).to eq(expected_filename)
    end
  end

  describe '.download_instagram_profile_pic' do
    # Mocking Selenium and Net::HTTP requests for this example
    let(:fake_driver) { instance_double(Selenium::WebDriver::Driver) }
    let(:fake_element) { instance_double(Selenium::WebDriver::Element) }
    let(:fake_response) { instance_double(Net::HTTPResponse, body: 'fake_image_data') }

    before do
      allow(Selenium::WebDriver).to receive(:for).and_return(fake_driver)
      allow(fake_driver).to receive(:get)
      allow(fake_driver).to receive_message_chain(:find_element, :attribute).with(:src).and_return('https://fakeimageurl.com/image.jpg')
      allow(fake_driver).to receive_message_chain(:find_element, :attribute).with(:alt).and_return("fake_user's profile picture")
      allow(Net::HTTP).to receive(:get_response).and_return(fake_response)
      allow(fake_response).to receive(:body).and_return('fake_image_data')
      expect(fake_driver).to receive(:quit).and_return(nil)

    end


    it 'downloads the image and generates the correct filename' do
        expect(FileUtils).to receive(:mkdir_p).with(InstagramDownloadProfilePic::Downloader::TMP_FOLDER)
  
        # Adjust the expect statements to match the new mocking setup
        expect(fake_driver).to receive(:find_element).with(:xpath, //).and_return(fake_element)
        expect(fake_element).to receive(:attribute).with('src').and_return('https://fakeimageurl.com/image.jpg')
        expect(fake_element).to receive(:attribute).with('alt').and_return("fake_user's profile picture")
  
        expect(File).to receive(:open).with(/profile_pic_fake_user_s_profile_picture\.jpg/, 'wb')
  
        described_class.download_instagram_profile_pic('https://www.instagram.com/fake_user/')
      end
  end
end
