$solr = lambda {
  config = HashWithIndifferentAccess.new(YAML.load(File.read(Rails.root + 'config' +'solr.yml')))
  DelSolr::Client.new(config[Rails.env].merge(:logger => Rails.logger))
}.call