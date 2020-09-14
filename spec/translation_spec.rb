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

    english = Translation.prepare_string("12He;l56lo")

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

RSpec.describe "Translation#prepare_string", :type => :model do

    english = Translation.prepare_string("12He;l56lo")

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