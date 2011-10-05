class Panopticon
  def initialize(panopticon_id)
    @panopticon_id = panopticon_id
  end
  
  def need_id
    attributes['need_id']
  end
  
  def public_url
    Plek.current.find('frontend') + '/' + attributes['slug']
  end
  
  def self.find(panopticon_id)
    new(panopticon_id)
  end

  def attributes
    raw_data = open(panopticon_uri).read
    data = JSON.parse(raw_data)
    data.except('updated_at', 'created_at', 'id', 'owning_app', 'kind', 'active')
  rescue OpenURI::HTTPError
    {}
  end
  private :attributes

  def panopticon_uri
    Plek.current.find("arbiter") + '/artefacts/' + @panopticon_id.to_s + '.js'
  end
  private :panopticon_uri
end
