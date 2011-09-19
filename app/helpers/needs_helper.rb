module NeedsHelper
  def start_work_link need
    start_work = "http://#{Plek.current.panopticon}/artefacts"

    form_tag start_work do |f|
      [
        hidden_field_tag("artefact[need_id]", need.id).html_safe,
        hidden_field_tag("artefact[kind]", need.kind.to_s.downcase).html_safe,
        hidden_field_tag("artefact[name]", need.title).html_safe,
        hidden_field_tag("artefact[tags]", need.tag_list).html_safe
      ].join.html_safe + \
      submit_tag('Start work on this need', :disable_with => 'Working...', :class => 'fulfill').html_safe
    end.html_safe
  end
end
