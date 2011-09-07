$(function() {
  var number_of_extra_cols = $('#needs-table > thead > tr > th').length - 3;
  var search_cols = [
    null,
    null,
    null
  ];
  for (var i = 0; i < number_of_extra_cols; i++) {
    search_cols.push({bSortable: false, sSearch: ""});
  }
  $('#needs-table').dataTable({
    bPaginate: false,
    oSearch: {sSearch: ""},
    aoSearchCols: search_cols
  });
  // Fact-checking contacts

  var form_base_url = $('#fact_checkers_list').closest('form').attr('action');
  var create_fact_checker_url = form_base_url + '/fact_checkers';
  var fact_checker_url = function(node) {
    return create_fact_checker_url + '/' + node.find('input').val() + '.json';
  };
  var csrf_param = $('meta[name=csrf-param]').attr('content');
  var csrf_token = $('meta[name=csrf-token]').attr('content');

  var set_up_existing_contact_li = function(contact_node) {
    var button = $('<span class="button">-</span>');
    button.appendTo(contact_node);
    button.click(function() {
      var data = {};
      data[csrf_param] = csrf_token;
      $.ajax(fact_checker_url(contact_node), {
        data: data, dataType: 'text', type: 'DELETE', 
        success: function() { 
          contact_node.remove();
        }
      });
    });
  };
  $('#fact_checkers_list li.existing').each(function() {
    set_up_existing_contact_li($(this));
  });
  $('#fact_checkers_list li[class!=existing]').each(function() {
    var button = $('<span class="button">+</span>');
    var contact_add_node = $(this);
    contact_add_node.append(button);
    contact_add_node.find('input').autocomplete({source: create_fact_checker_url + '/search.json'});
    button.click(function() {
      var form_data = {fact_checker: {contact: {email: contact_add_node.find('input').val()}}};
      $.post(create_fact_checker_url + '.json', form_data, function(data) {
        var fact_checker = data;
        var new_contact_node = $('<li class="existing">' + fact_checker.contact.email + '<input name="fact_checkers[' + fact_checker.id + ']" type="hidden" value="' + fact_checker.id + '">');
        contact_add_node.before(new_contact_node);
        set_up_existing_contact_li(new_contact_node);
      }, 'json');
    });
  });
});
