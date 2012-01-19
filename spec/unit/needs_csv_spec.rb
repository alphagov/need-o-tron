require "spec_helper"
require "csv"

describe NeedsCsv do
  before do
    stub_request(:get, %r{http://panopticon.*}).
      to_return(:status => 200, :body => "{}")
  end

  it "should have a header row" do
    csv = NeedsCsv.new([], Time.now).to_csv
    data = CSV.parse(csv)
    data[0][0].should == "Id"
  end

  it "should convert writing department to a string" do
    wd = FactoryGirl.create(:writing_department, name: "Ministry of Magic")
    need = FactoryGirl.create(:need,
      indexer: NullIndexer,
      writing_department: wd
    )
    need.reload
    csv = NeedsCsv.new([need], Time.now).to_csv
    data = CSV.parse(csv)
    headers = data[0]
    rows = data[1..-1].map { |cols| Hash[headers.zip(cols)] }
    rows[0]["Writing dept"].should == "Ministry of Magic"
  end

end
