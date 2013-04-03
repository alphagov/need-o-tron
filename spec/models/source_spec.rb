require 'spec_helper'

describe Source do

  describe "a new source" do
    before do
      @need = FactoryGirl.create(:need)
      @atts = {
        :title => "UK bank holidays and time off - Directgov",
        :url => "http://www.direct.gov.uk/en/DG_1234567",
        :kind => "directgov",
        :body => "List of bank holidays for England and Wales, Scotland and Northern Ireland for 2012-2015",
      }
    end

    it "can be created given valid attributes" do
      @source = @need.sources.build(@atts)
      @source.should be_valid

      @source.save
      @source.should be_persisted
    end

    it "is not valid when kind is empty" do
      @source = @need.sources.build(@atts.merge(:kind => ''))
      @source.should_not be_valid
      @source.errors.keys.should == [:kind]
    end

    it "is not valid when kind isn't in the list" do
      @source = @need.sources.build(@atts.merge(:kind => 'something_else'))
      @source.should_not be_valid
      @source.errors.keys.should == [:kind]
    end
  end

end
