require "spec_helper"
require "csv"

describe NeedsCsv do
  before do
    stub_request(:get, %r{http://panopticon.*}).
      to_return(:status => 200, :body => "{}")
    @need = Need.create
  end

  it "should have a header row" do
    csv = NeedsCsv.new([], Time.now).to_csv
    data = CSV.parse(csv)
    data[0][0].should == "Id"
  end


  it "can report fact checkers so they can be included in a CSV" do
    @need.fact_checkers.create(email: 'matt@alphagov.co.uk')
    @need.fact_checkers.create(email: 'ben@alphagov.co.uk')

    csv = NeedsCsv.new([], Time.now)
    csv.fact_checkers(@need) == "matt@alphagov.co.uk, ben@alphagov.co.uk"
  end

  it "should convert writing department to a string" do
    wd = FactoryGirl.create(:writing_department, name: "Ministry of Magic")
    need = FactoryGirl.create(:need, writing_department: wd)
    need.reload
    csv = NeedsCsv.new([need], Time.now).to_csv
    data = CSV.parse(csv)
    headers = data[0]
    rows = data[1..-1].map { |cols| Hash[headers.zip(cols)] }
    rows[0]["Writing dept"].should == "Ministry of Magic"
  end

end
