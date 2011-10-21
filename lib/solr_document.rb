class SolrDocument
  extend Forwardable

  def initialize
    @doc = DelSolr::Document.new
  end

  def add_field(key, value)
    @doc.add_field key, CGI.escapeHTML(value.to_s)
  end

  def_delegators :@doc, :xml
end
