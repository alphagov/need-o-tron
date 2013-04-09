class ChangeExistingServicesToSources < ActiveRecord::Migration
  def up
    ExistingService.all.each do |service|
      Source.create!(
        :title => service.description,
        :url => service.link,
        :kind => 'existing_service',
        :need_id => service.need_id
      )
      service.destroy
    end
  end

  def down
    Source.where(:kind => 'existing_service').all.each do |source|
      ExistingService.create!(
        :link => source.url,
        :description => source.title.present? ? source.title : "-",
        :need_id => source.need_id
      )
      source.destroy
    end
  end
end
