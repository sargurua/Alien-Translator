require 'rails_helper'

RSpec.describe Translation, :type => :model do

    subject {
        described_class.new(
            english: "Placeholder",
            gorbyoyo: "placeholder"
        )
    }

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without an english field" do
        subject.english = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without a gorbyoyo field" do
        subject.gorbyoyo = nil
        expect(subject).to_not be_valid
    end
end

RSpec.describe "Translation#prepare_string", :type => :model do

    string = Translation.prepare_string("12He;l56lo")

    it "prepare_string removes numbers from string" do
       expect(string.scan(/\d/).size).to eq(0)
    end

    it "prepare_string removes punctuation from string" do
       expect(string.count(";")).to eq(0)
    end

    it "prepare_string outputs the correct formatted result" do
       expect(string).to eq("hello")
    end

end

RSpec.describe "Translation#translate_to_dorbdorb", :type => :model do

    english = Translation.prepare_string("12He;l56lo")
    dorbdorb = Translation.translate_to_dorbdorb(english)

    it "translate_to_dorbdorb returns an array" do
       expect(dorbdorb.class).to eq(Array)
    end

    it "translate_to_dorbdorb turns each character into string in array" do
       expect(english.length).to eq(dorbdorb.length)
    end

end

RSpec.describe "Translation#translate_to_gorbyoyo", :type => :model do

    string = ["10L13"]
    gorbyoyo = Translation.translate_to_gorbyoyo(string)

    it "translate_to_gorbyoyo returns a string" do
       expect(gorbyoyo.class).to eq(String)
    end

    it "translate_to_gorbyoyo correctly translates array of strings" do
       expect(gorbyoyo).to eq("Lyo23")
    end

end

RSpec.describe "Translation#verify_translation", :type => :model do

    gorbyoyo = Translation.translate("i am not selling knives")[1]

    it "verify_translation returns Sucess on correct translation" do
       expect(Translation.verify_translation(gorbyoyo)).to eq("Success")
    end

    it "verify_translation returns Invalid translation on incorrect translation" do
       expect(Translation.verify_translation("wrong")).to eq("Invalid translation")
    end

end


