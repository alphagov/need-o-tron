module NeedsHelper
  def start_work_link need
    start_work = "#{Plek.current.find("arbiter")}/artefacts/new"

    form_tag start_work, :method => 'get' do
      [
        hidden_field_tag("artefact[need_id]", need.id).html_safe,
        hidden_field_tag("artefact[kind]", need.kind.to_s.downcase).html_safe,
        hidden_field_tag("artefact[tags]", need.tag_list).html_safe
      ].join.html_safe + \
      submit_tag('Start work on this need', :disable_with => 'Working...', :class => 'fulfill').html_safe
    end.html_safe
  end

  def assign_work_link need
    start_work =  "#{Plek.current.find("arbiter")}/artefacts"
    start_work += "?return_to=#{Plek.current.find("needs")}#{request.fullpath}"

    form_tag start_work, :method => 'post' do
      [
        hidden_field_tag("artefact[name]", "[#{need.id}] I need to be changed").html_safe,
        hidden_field_tag("artefact[slug]", "#{need.id}-i-need-to-be-changed").html_safe,
        hidden_field_tag("artefact[owning_app]", "publisher").html_safe,
        hidden_field_tag("artefact[need_id]", need.id).html_safe,
        hidden_field_tag("artefact[kind]", need.kind.to_s.downcase).html_safe,
        hidden_field_tag("artefact[tags]", need.tag_list).html_safe
      ].join.html_safe + \
      submit_tag('Assign need', :disable_with => 'Working...', :class => 'fulfill').html_safe
    end.html_safe
  end
  
  def search_link_with_added_filter(params, filters, additional_filters)
    new_params = deep_copy(params.to_hash)
    new_filters = deep_copy(filters.to_hash)
    additional_filters.each do |field, value|
      new_filters[field] ||= []
      new_filters[field] << value
    end
    new_params["filters"] = filter_to_path(new_filters)
    filtered_search_path(new_params)
  end
    
  def search_link_with_removed_filter(params, filters, filters_to_remove)
    new_params = deep_copy(params.to_hash)
    new_filters = deep_copy(filters.to_hash)
    filters_to_remove.each do |field, value|
      next unless new_filters.has_key?(field)
      new_filters[field].delete(value)
    end
    new_params["filters"] = filter_to_path(new_filters)
    new_params.delete("filters") unless new_params["filters"]
    filtered_search_path(new_params)
  end

  def search_link_for_page(params, filters, page)
    new_params = deep_copy(params.to_hash)
    new_params["filters"] = filter_to_path(filters)
    new_params['page'] = page
    filtered_search_path(new_params)
  end
  
  def filter_to_path(filters_hash)
    path = []
    filters_hash.each do |field, values|
      values.each do |value|
        path.concat([field,value])
      end
    end
    path
  end
  
  def filtering_by?(field, value)
    @filters[field] && @filters[field].include?(value)
  end
  
  private
    def deep_copy(object)
      Marshal.restore(Marshal.dump(object))
    end
end
