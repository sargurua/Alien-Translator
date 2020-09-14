class TranslationController < ApplicationController

    def index
        @previous_translation = Translation.all.last
    end

    def create
        translation_array = Translation.translate(params[:translation][:english])
        translation_params = {english: translation_array[0], gorbyoyo: translation_array[1]}
        
        Translation.create(translation_params)

        redirect_to action: "index"
    end

    private

        def translation_params
            params.require(:translation).permit(:english, :gorbyoyo)
        end
end
