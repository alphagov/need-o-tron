module NeedsHelper
  def start_work_link need
    start_work = "#{Plek.current.find("arbiter")}/artefacts/new"

    form_tag start_work, :method => 'get', :target => '_blank' do
      [
        hidden_field_tag("artefact[name]", "CHANGE ME: #{need.title}").html_safe,
        hidden_field_tag("artefact[owning_app]", "publisher").html_safe,
        hidden_field_tag("artefact[need_id]", need.id).html_safe,
        hidden_field_tag("artefact[kind]", need.kind.to_s.downcase).html_safe,
        hidden_field_tag("artefact[tags]", need.tag_list).html_safe
      ].join.html_safe + \
      submit_tag('Start work on this need', :disable_with => 'Working...', :class => 'fulfill').html_safe
    end.html_safe
  end

  def assign_work_link need
    start_work =  "#{Plek.current.find("arbiter")}/artefacts"
    start_work += "?return_to=#{CGI.escape(request.url)}"

    form_tag start_work, :method => 'post', :target => '_blank' do
      [
        hidden_field_tag("artefact[name]", "CHANGE ME: #{need.title}").html_safe,
        hidden_field_tag("artefact[slug]", "change-me-for-need-#{need.id}").html_safe,
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
    new_params.delete('page')
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
    new_params.delete('page')
    new_filters = deep_copy(filters.to_hash)
    filters_to_remove.each do |field, value|
      next unless new_filters.has_key?(field)
      new_filters[field].delete(value)
    end
    new_params["filters"] = filter_to_path(new_filters)
    new_params.delete("filters") unless new_params["filters"]
    filtered_search_path(new_params)
  end

  def search_link_for_page(params, filters = nil, page = nil)
    new_params = deep_copy(params.to_hash)
    if filters
      new_params["filters"] = filter_to_path(filters)
    end
    new_params.delete('page')
    new_params['page'] = page if page
    filtered_search_path(new_params)
  end

  def filter_to_path(filters_hash)
    path = []
    filters_hash.each do |field, values|
      [*values].each do |value|
        path.concat([field,value])
      end
    end
    path
  end
  
  def filtering_by?(field, value)
    @filters[field] && @filters[field].include?(value)
  end
  
  def pagination_link(page_number, label, classes = [])
    classes = classes.is_a?(String) ? classes.split(' ') : classes.clone
    classes << 'disabled' unless @search.pages.include?(page_number)
    classes << 'active' if @current_page == page_number
    if (classes & %w{disabled active}).present?
      content_tag(:li, class: classes) do
        content_tag(:span, label)
      end
    else
      content_tag(:li, class: classes) do
        link_to label, search_link_for_page(params, @filters, page_number)
      end
    end
  end

  def sortable_heading(field)
    css_classes = []
    new_sort_dir = 'asc'
    if params[:sort_by] == field
      raise "Bad sort dir" unless %w{asc desc}.include?(params[:sort_dir])
      css_classes << "sorting-#{params[:sort_dir]}"
      new_sort_dir = params[:sort_dir] == 'asc' ? 'desc' : 'asc'
    end
    content_tag(:th, :class => css_classes, :scope => 'col') do
      link_to(t("field.short.#{field}"), search_link_for_page(params.merge(sort_by: field, sort_dir: new_sort_dir)))
    end
  end
  
  def deep_copy(object)
    Marshal.restore(Marshal.dump(object))
  end
end
