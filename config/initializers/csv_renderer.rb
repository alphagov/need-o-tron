require 'action_controller/metal/renderers'

# Assumes you're passing in a subclass or interface-implementing version of CsvRenderer
ActionController::Renderers.add :csv do |csv_data, options|
  send_data csv_data.to_csv, :type => :csv, :filename => csv_data.csv_filename(params)
end
#Mime::Type.register_alias "text/csv", :csv
