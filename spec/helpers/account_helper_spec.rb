require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AccountHelper. For example:
#
# describe AccountHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AccountHelper, type: :helper do
  describe "#user_stylesheet_url" do
    it "uses custom url if present" do
      sheet = CustomStylesheet.new stylesheet: "https://abc.int/foo/bar.css"
      account = FactoryGirl.build :account, custom_stylesheet: sheet
      expect(helper.user_stylesheet_url(account)).to eq("https://abc.int/foo/bar.css")
    end

    it "manipulates PHP paths" do
      # This needs to be a path to a real stylesheet
      display = DisplayPreference.new style: Style.new(path: "styles/blue/blue.css")
      account = FactoryGirl.create :account, display_preference: display
      expect(helper.user_stylesheet_url(account)).to eq("http://test.host/assets/blue/blue.css")
    end
  end
end
