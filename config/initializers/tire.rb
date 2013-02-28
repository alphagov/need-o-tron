if Rails.env.production?
  Tire.configure {
  	url "http://support.cluster:9200"
    logger Rails.root.join("log/tire_#{Rails.env}.log")
  }
elsif Rails.env.development?
  Tire.configure {
    url "http://localhost:9200"
    logger Rails.root.join("log/tire_#{Rails.env}.log")
  }
else
  Tire.configure {
    url "http://localhost:9200"
    logger Rails.root.join("log/tire_#{Rails.env}.log")
  }
end
