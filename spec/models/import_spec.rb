require 'spec_helper'

describe Import do
  it_should_behave_like "ActiveModel"

  def csv(path)
    Rack::Test::UploadedFile.new(File.expand_path("../../fixtures/#{path}", __FILE__), 'text/csv', false)
  end

  describe "which things to import" do
    it "only allows methods in IMPORT_OPTIONS and which are set as import keys" do
      import = Import.new(:priority => "1", :fact_checker => "0", :bad => "1")
      import.import_keys.should == [:priority]
    end
  end

  describe "importing priorities" do
    before(:each) do
      @need = Need.make
    end

    it "updates the need's priority" do
      @need.expects(:save).returns(true)
      Need.expects(:find_by_id).with('1').returns(@need)

      import = Import.new :csv => csv('import_sample.csv'), :priority => '1'
      import.save

      @need.priority.should == 3
    end
  end

  describe "importing fact checkers" do
    describe "reporting which Fact Checkers to remove or add" do
      it "correctly reports which Fact Checkers to remove and which to add" do
        current = ['matt@alphagov.co.uk', 'ben@alphagov.co.uk']
        updated = ['ben@alphagov.co.uk', 'james@alphagov.co.uk']
        to_add, to_delete = Import::Updaters.fact_checker_changes(current, updated)
        to_add.should equal_set(['james@alphagov.co.uk'])
        to_delete.should equal_set(['matt@alphagov.co.uk'])
      end

      it "correctly reports additions when there are no pre-existing fact-checkers" do
        current = []
        updated = ['ben@alphagov.co.uk', 'james@alphagov.co.uk']
        to_add, to_delete = Import::Updaters.fact_checker_changes(current, updated)
        to_add.should equal_set(['ben@alphagov.co.uk', 'james@alphagov.co.uk'])
        to_delete.should  equal_set([])
      end

      it "correctly reports no additions or deletions when there's no change" do
        current = ['matt@alphagov.co.uk']
        updated = ['matt@alphagov.co.uk']
        to_add, to_delete = Import::Updaters.fact_checker_changes(current, updated)
        to_add.should equal_set([])
        to_delete.should  equal_set([])
      end

      it "correctly reports all deletions when fact checkers are removed from updated" do
        current = ['matt@alphagov.co.uk']
        updated = []
        to_add, to_delete = Import::Updaters.fact_checker_changes(current, updated)
        to_add.should equal_set([])
        to_delete.should  equal_set(['matt@alphagov.co.uk'])
      end
    end

    describe "extracting a list of Fact Checkers from the CSV" do
      it "correctly extracts one" do
        Import::Updaters.extract_fact_checkers('matt@alphagov.co.uk').should == ['matt@alphagov.co.uk']
      end

      it "correctly extracts two" do
        Import::Updaters.extract_fact_checkers('matt@alphagov.co.uk, ben@alphagov.co.uk').should == ['matt@alphagov.co.uk', 'ben@alphagov.co.uk']
      end

      it "correctly extracts none" do
        Import::Updaters.extract_fact_checkers('').should == []
      end
    end

    describe "modifying Fact Checkers" do
      it "correctly orders the deletion and creation of fact checkers" do
        need = mock()

        need.expects(:current_fact_checker_emails).returns(['matt@alphagov.co.uk', 'james@alphagov.co.uk'])
        need.expects(:add_fact_checker_with_email).with('ben@alphagov.co.uk')
        need.expects(:remove_fact_checker_with_email).with('james@alphagov.co.uk')

        Import::Updaters.fact_checker(need, {'Fact checker' => 'matt@alphagov.co.uk, ben@alphagov.co.uk'})
      end
    end

    # before(:each) do
    #   @need = Need.make

    #   @need.expects(:save).returns(true)
    #   Need.expects(:find_by_id).with('1').returns(@need)
    # end

    # def do_import
    #   import = Import.new :csv => csv('import_with_new_fact_checker.csv'), :fact_checker => '1'
    #   import.save
    # end

    # it "updates the need's Fact Checkers" do
    #   do_import

    #   @need.fact_checkers.length.should == 1
    #   @need.fact_checkers.first.contact.email.should == 'matt@alphagov.co.uk'
    # end

    # it "removes excess Fact Checkers" do
    #   @need.fact_checkers << FactChecker.make

    #   do_import

    #   @need.fact_checkers.length.should == 1
    #   @need.fact_checkers.first.contact.email.should == 'matt@alphagov.co.uk'
    # end

    # it "removes excess Fact Checkers" do
    #   Import::Updaters.fact_checker(@need, {'Fact checker' => 
    # end
  end
end
