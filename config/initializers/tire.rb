Tire.configure {
  url "http://support.cluster:9200"
  logger Rails.root.join("log/tire_#{Rails.env}.log")
}
