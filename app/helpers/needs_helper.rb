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
end
