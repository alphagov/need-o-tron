class CsvRenderer
  def initialize(data, timestamp)
    @data = data
    @timestamp = timestamp
  end
  
  # :api:
  # should return a CSV object
  # i.e. something like
  # 
  # def to_csv
  #   CSV.generate do |csv|
  #     csv << ["Column head", "Column head 2"]
  #     @data.each do |item|
  #       csv << [item.x, item.y]
  #     end
  #   end
  # end
  def to_csv
    raise NotImplementedError
  end
  
  # :api:
  # return the filename for the Content-Disposition header
  def csv_filename(params)
    raise NotImplementedError
  end
end
