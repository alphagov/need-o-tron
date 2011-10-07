require 'spec_helper'

describe SatisfiedNeedListener do
  def panopticon_will_respond_with(metadata)
    stub_request(:get, %r{http://panopticon.*/artefacts/.*\.js}).
      to_return(:status => 200, :body => metadata.to_json)
  end
  
  it 'marks a need as done and records the public url when a message received' do
    need = FactoryGirl.create(:need)
    panopticon_will_respond_with(need_id: need.id, slug: 'my_slug')
    need_satisfied_message = stub(
      body: {panopticon_id: "any_old_thing"}.to_json,
      headers: {'message-id' => '123'}
    )
    stomp_client = stub(join: nil, close: nil, acknowledge: nil)
    stomp_client.expects(:subscribe).yields(need_satisfied_message)
    SatisfiedNeedListener.client = stomp_client
    SatisfiedNeedListener.new.listen
    need.reload
    need.should be_done
    need.url.should =~ %r{/my_slug$}
  end
end
