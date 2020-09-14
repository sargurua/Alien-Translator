class Translation < ApplicationRecord
    #Make sure for Translation object to have attributtes if created.
    validates_presence_of :english
    validates_presence_of :gorbyoyo

    #Main Translate function calls other function to take string and fully translate, also check for if string.
    #needs to be verified if string is "i am not selling knives" or is prepared to that.
    def self.translate(input_string)
        #Main logic changes string to Gorbyoyo.
        english = Translation.prepare_string(input_string)
        dorbdorb = Translation.translate_to_dorbdorb(english)
        gorbyoyo = Translation.translate_to_gorbyoyo(dorbdorb)

        #Check to see if prepared string turned into "i am not selling knives" if it is it can be verified by the API.
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

    #Uses endpoint to verify phrase "i am not selling knives".
    def self.verify_translation(gorbyoyo_translation)
        #Sends apps translation of gorbyoyo and sends it to endpoint and gets a response string.
        response = HTTParty.post("https://72exx40653.execute-api.us-east-1.amazonaws.com/prod/confirmtranslation",
              :body => {:textToVerify => gorbyoyo_translation}.to_json,
              :headers => {'Content-Type' => 'application/json'}
        ).to_s

    end

    #Function turns DorbDorb into Gorbyoyo, it expects an array of strings and uses guide to transform them into Gorbyoyo.
    def self.translate_to_gorbyoyo(dorbdorb_response)
        #Creates string by joining an array where each string in the Dorbdorb array is broken into parts an int1, char, int2.
        #Those parts are reconstructed into char + yo + (int1 + int2).
        gorbyoyo_translation = dorbdorb_response.map do |dorbdorb_string|
            dorbdorb_array = dorbdorb_string.scan(/\d+|\D+/)
            gorbyoyo = "#{dorbdorb_array[1]}yo#{dorbdorb_array[0].to_i + dorbdorb_array[2].to_i}"
        end.join("")

    end

    #Function turns prepared english string into Dorbdorb by calling endpoint with array as return.
    def self.translate_to_dorbdorb(english_string)
        #Json response is an array with each character in string converted into Dorbdorb.
        HTTParty.post("https://72exx40653.execute-api.us-east-1.amazonaws.com/prod/translateEnglishToAlien",
              :body => {:textToTranslate => english_string}.to_json,
              :headers => {'Content-Type' => 'application/json'}
        ).parsed_response

    end

    #Function uses gsub to remove punctuation and digits from string. Returns string without those characters.
    def self.prepare_string(input_string)

        input_string.downcase.gsub(/[^a-z\s]/i, '')

    end
end
