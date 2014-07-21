class AddOrganisationSlugToUser < ActiveRecord::Migration
  def change
    add_column :users, :organisation_slug, :string
  end
end
