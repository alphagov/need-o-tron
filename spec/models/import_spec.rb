require 'spec_helper'

describe Import do
  it_should_behave_like "ActiveModel"

  describe "importing priorities" do
    before(:each) do
      @need = Need.new
    end

    def csv(path)
      Rack::Test::UploadedFile.new(File.expand_path("../../fixtures/#{path}", __FILE__), 'text/csv', false)
    end

    it "Should update the need's priority" do
      @need.expects(:save).returns(true)
      Need.expects(:find_by_id).with('1').returns(@need)

      import = Import.new :csv => csv('import_sample.csv'), :priority => '1'
      import.save

      @need.priority.should == 3
    end
  end
end
