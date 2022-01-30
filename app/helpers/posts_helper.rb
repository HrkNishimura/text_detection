module PostsHelper
  def request_to_api(image)
    vision_api_key = ENV['VISION_API_KEY']
    vision_api_url = URI("https://vision.googleapis.com/v1/images:annotate?key=#{vision_api_key}")

    headers = { 'Content-Type' => 'application/json' }
    body = {
      requests: [
        {
          image: {
            content: image
          },
          features: [
            {
              type: 'TEXT_DETECTION'
            }
          ]
        }
      ]
    }.to_json

    begin
      JSON.parse(Net::HTTP.post(vision_api_url, body, headers).body)['responses'][0]['textAnnotations'][0]['description']
    rescue NoMethodError => e
      return
    end
  end
end
