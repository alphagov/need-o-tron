require_relative 'integration_helper'

describe "Need integration with Solr" do
  describe "when a need is created" do
    it "is immediately findable in Solr" do
      need = Factory :need, :title => "Lorem ipsum dolor sit amet"
      search = NeedSearch.new "ipsum"
      results = search.execute
      results.should have(1).result
      results.first.should == {
        "id" => need.id,
        "title" => need.title, 
        "description" => need.description.to_s,
        "status" => need.status
      }
    end
  end
end