class TranslationController < ApplicationController

    def index
        #Main route check for existince of previous translation route redirect
        #if so display vaariable becomes past translation chosen
        #else display last translation created

        @translations = Translation.all
        if params[:past_translation]
            @previous_translation = @translations.find(params[:past_translation])
        else
            @previous_translation = @translations.last
        end
    end

    def create
        #Check input to make sure it meets standard. If not no create (could not get sweetify to work on Rails)
        #Sends back to index route

        if (params[:translation][:english].length > 0 && params[:translation][:english].length < 70)
            translation_array = Translation.translate(params[:translation][:english])
            translation_params = {english: translation_array[0], gorbyoyo: translation_array[1]}
            
            Translation.create(translation_params)
        end

        redirect_to action: "index"
    end

    def past_search
        #Route sends chosen past translation to index route to be displayed through params

        found_translation = Translation.all.find(params[:id])

        redirect_to action: "index", past_translation: found_translation
    end

    #Strong params used to make sure correct information is given through params and creation
    private

        def translation_params
            params.require(:translation).permit(:english, :gorbyoyo)
        end
end
