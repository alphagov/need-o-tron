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
      @need.expects(:save!).returns(true)
      Need.expects(:find_by_id).with('1').returns(@need)

      import = Import.new :csv => csv('import_sample.csv'), :priority => '1'
      import.save

      @need.priority.should == 3
    end
  end
  
  describe "importing writing department" do
    before(:each) do
      @need = Need.make
    end

    it "updates the need's writing department" do
      @need.expects(:save!).returns(true)
      Need.expects(:find_by_id).with('1').returns(@need)

      import = Import.new :csv => csv('import_with_writing_dept.csv'), :writing_dept => '1'
      import.save

      @need.writing_department.to_s.should == "DoSAC"
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
  end

  describe "importing Accountabilities" do
    describe "reporting which Accountabilities to remove or add" do
      it "correctly reports which Accountabilities to remove and which to add" do
        current = ['HM Treasury', 'DoSAC']
        updated = ['DoSAC', 'MAFF']
        to_add, to_delete = Import::Updaters.accountability_changes(current, updated)
        to_add.should equal_set(['MAFF'])
        to_delete.should equal_set(['HM Treasury'])
      end

      it "correctly reports additions when there are no pre-existing fact-checkers" do
        current = []
        updated = ['DoSAC', 'MAFF']
        to_add, to_delete = Import::Updaters.accountability_changes(current, updated)
        to_add.should equal_set(['DoSAC', 'MAFF'])
        to_delete.should  equal_set([])
      end

      it "correctly reports no additions or deletions when there's no change" do
        current = ['HM Treasury']
        updated = ['HM Treasury']
        to_add, to_delete = Import::Updaters.accountability_changes(current, updated)
        to_add.should equal_set([])
        to_delete.should  equal_set([])
      end

      it "correctly reports all deletions when fact checkers are removed from updated" do
        current = ['HM Treasury']
        updated = []
        to_add, to_delete = Import::Updaters.accountability_changes(current, updated)
        to_add.should equal_set([])
        to_delete.should equal_set(['HM Treasury'])
      end
    end

    describe "extracting a list of Fact Checkers from the CSV" do
      it "correctly extracts one" do
        Import::Updaters.extract_accountabilities('HM Treasury').should == ['HM Treasury']
      end

      it "correctly extracts two" do
        Import::Updaters.extract_accountabilities('HM Treasury, DoSAC').should == ['HM Treasury', 'DoSAC']
      end

      it "correctly extracts none" do
        Import::Updaters.extract_accountabilities('').should == []
      end
    end

    describe "modifying Accountability" do
      it "correctly orders the deletion and creation of accountabilities (lead departments)" do
        need = mock()

        need.expects(:current_accountability_names).returns(['HM Treasury', 'MAFF'])
        need.expects(:add_accountability_with_name).with('DoSAC')
        need.expects(:remove_accountability_with_name).with('MAFF')

        Import::Updaters.lead_department(need, {'Lead department' => 'HM Treasury, DoSAC'})
      end
    end
  end
end
