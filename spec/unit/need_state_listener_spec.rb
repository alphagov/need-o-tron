require 'spec_helper'

describe NeedStateListener do
  before(:each) do
    Need.any_instance.stubs(:update_search_index).returns(true)
    stomp_client = stub(join: nil, close: nil, acknowledge: nil, subscribe: nil)
    NeedStateListener.client = stomp_client
  end

  it 'marks a need as done and records the public url when a message received' do
    need = FactoryGirl.create(:need, :indexer => NullIndexer)
    panopticon_url = panopticon_has_metadata('id' => 12345, 'need_id' => need.id, 'slug' => 'my_slug')

    listener = NeedStateListener.new
    listener.act_on_published({'panopticon_id' => 12345})
    
    need.reload
    need.should be_done
    need.url.should =~ %r{/my_slug$}
  end
end
