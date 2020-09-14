class TranslationController < ApplicationController

    def index
        @translations = Translation.all
        if params[:past_translation]
            @previous_translation = @translations.find(params[:past_translation])
        else
            @previous_translation = @translations.last
        end
    end

    def create

        if (params[:translation][:english].length > 0 && params[:translation][:english].length < 70)
            translation_array = Translation.translate(params[:translation][:english])
            translation_params = {english: translation_array[0], gorbyoyo: translation_array[1]}
            
            Translation.create(translation_params)
        end

        redirect_to action: "index"
    end

    def past_search
        found_translation = Translation.all.find(params[:id])

        redirect_to action: "index", past_translation: found_translation
    end

    private

        def translation_params
            params.require(:translation).permit(:english, :gorbyoyo)
        end
end
