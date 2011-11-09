require_relative 'integration_helper'

describe "Need integration with Solr" do
  describe "when a need is created" do
    before :each do
      $solr.delete_by_query("rails_env:#{Rails.env}")
      @need = Factory :need, 
        title: "Lorem ipsum dolor sit amet", 
        kind: Factory(:kind),
        priority: Need::PRIORITIES.values.first,
        tag_list: "red,blue"
    end
      
    it "is immediately findable in Solr" do 
      search = NeedSearch.new "ipsum"
      search.execute
      search.results.should have(1).result
      result = search.results.first
      result.id.should == @need.id
      result.title.should == @need.title
      result.tag.should == ["red", "blue"]
      result.kind.should == @need.kind.name
      result.priority.should == @need.priority.to_s
    end

    it "can be broken down by facets" do
      search = NeedSearch.new "ipsum", facet_by: ['kind']
      search.execute
      search.facets.should == {"kind" => [@need.kind.name, 1]}
    end

    it "can be searched by kind" do
      search = NeedSearch.new "", filters: {kind: @need.kind.name}
      search.execute
      search.results.first.id.should == @need.id
    end

  end
end