class Translation < ApplicationRecord
    validates_presence_of :english
    validates_presence_of :gorbyoyo

    def self.translate(input_string)

        english = Translation.prepare_string(input_string)
        dorbdorb = Translation.translate_to_dorbdorb(english)
        gorbyoyo = Translation.translate_to_gorbyoyo(dorbdorb)

        if (english == "i am not selling knives")
            if (Translation.verify_translation(gorbyoyo) == "Success")
                return [english, gorbyoyo]
            else    
                return "Error in translation"
            end
        else
            return [english, gorbyoyo]
        end

    end

    def self.verify_translation(gorbyoyo_translation)

        response = HTTParty.post("https://72exx40653.execute-api.us-east-1.amazonaws.com/prod/confirmtranslation",
              :body => {:textToVerify => gorbyoyo_translation}.to_json,
              :headers => {'Content-Type' => 'application/json'}
        ).to_s

    end

    def self.translate_to_gorbyoyo(dorbdorb_response)

        gorbyoyo_translation = dorbdorb_response.map do |dorbdorb_string|
            dorbdorb_array = dorbdorb_string.scan(/\d+|\D+/)
            gorbyoyo = "#{dorbdorb_array[1]}yo#{dorbdorb_array[0].to_i + dorbdorb_array[2].to_i}"
        end.join("")

    end

    def self.translate_to_dorbdorb(english_string)

        HTTParty.post("https://72exx40653.execute-api.us-east-1.amazonaws.com/prod/translateEnglishToAlien",
              :body => {:textToTranslate => english_string}.to_json,
              :headers => {'Content-Type' => 'application/json'}
        ).parsed_response

    end

    def self.prepare_string(input_string)

        input_string.downcase.gsub(/[^a-z\s]/i, '')

    end
end
