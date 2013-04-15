class ChangeDirectgovLinksToSources < ActiveRecord::Migration
  def up
    DirectgovLink.all.each do |link|
      Source.create!(
        :title => link.title,
        :url => link.url,
        :kind => 'legacy_service',
        :need_id => link.need_id
      )
      link.destroy
    end
  end

  def down
    Source.where(:kind => 'legacy_service').all.each do |source|
      DirectgovLink.create!(
        :directgov_id => source.url.match(%r{http://www.direct.gov.uk/en/(.*)}) {|m| m[1] },
        :need_id => source.need_id
      )
      source.destroy
    end
  end
end
