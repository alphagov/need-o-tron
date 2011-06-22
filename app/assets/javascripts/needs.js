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
});