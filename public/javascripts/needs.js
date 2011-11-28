$(function() {
  // Fact-checking contacts

  var form_base_url = $('#fact_checkers_list').closest('form').attr('action'); // this is still true even for accountabilities
  var csrf_param = $('meta[name=csrf-param]').attr('content');
  var csrf_token = $('meta[name=csrf-token]').attr('content');

  var set_up_existing_item_li = function(item_node, url_generator) {

  };
  var set_up_create_item_li = function(item_create_node, create_url, form_data_generator, item_creator, url_generator) {
    var create_text_field_node = item_create_node.find('input');
    create_text_field_node.autocomplete({source: create_url + '/search.json'});
    var create_function = function() {
      $.post(create_url + '.json', form_data_generator(item_create_node), function(data) {
        var new_item_node = item_creator(data);
        item_create_node.before(new_item_node);
        set_up_existing_item_li(new_item_node, url_generator);
      }, 'json');
    };
  }

  // Fact Checkers
  var create_fact_checker_url = form_base_url + '/fact_checkers';
  var fact_checker_url_generator = function(node) {
    return create_fact_checker_url + '/' + node.find('input').val() + '.json';
  };
  var fact_checker_create_data_generator = function(node) {
    return {fact_checker: {contact: {email: node.find('input').val()}}};
  };
  var fact_checker_item_creator = function(data) {
    return $('<li class="existing">' + data.contact.email + '<input name="fact_checkers[' + data.id + ']" type="hidden" value="' + data.id + '">');
  }
  $('#fact_checkers_list li.existing').each(function() {
    set_up_existing_item_li($(this), fact_checker_url_generator);
  });
  $('#fact_checkers_list li[class!=existing]').each(function() {
    set_up_create_item_li($(this), create_fact_checker_url,
                          fact_checker_create_data_generator,
                          fact_checker_item_creator, fact_checker_url_generator);
  });

  // Accountabilities
  var create_accountability_url = form_base_url + '/accountabilities';
  var accountability_url_generator = function(node) {
    return create_accountability_url + '/' + node.find('input').val() + '.json';
  };
  var accountability_create_data_generator = function(node) {
    return {accountability: {department: {name: node.find('input').val()}}};
  };
  var accountability_item_creator = function(data) {
    return $('<li class="existing">' + data.department.name + '<input name="accountabilities[' + data.id + ']" type="hidden" value="' + data.id + '">');
  }
  $('#accountabilities_list li.existing').each(function() {
    set_up_existing_item_li($(this), accountability_url_generator);
  });
  $('#accountabilities_list  li[class!=existing]').each(function() {
    set_up_create_item_li($(this), create_accountability_url,
                          accountability_create_data_generator,
                          accountability_item_creator, accountability_url_generator);
  });
});
