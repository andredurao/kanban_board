$("button[data-target-modal='#new-task-modal']").on("click", function() {
  $("#new-task-modal .error-descriptions").html("");
  $("#new-task-modal input[type='radio']").first().attr("checked", true);
  var currentStatus = $(this).data("status");
  $("#new-task-modal input[name='[task][current_status]']").val(currentStatus);

  $("#new-task-modal").modal('show');
});

$("#new-task-modal-submit").on("click", function() {

  var boardId = $("#new-task-modal").data("kanban-board-id");
  var formdata = $("#new-task-modal form").serializeArray();
  var data = {};
  $(formdata).each(function(index, obj) {
    data[obj.name] = obj.value;
  });

  $.post("/kanban_boards/" + boardId + "/tasks.json", data).
  done(function(data) {
      $('#new-task-modal').modal('hide');
      var compiled = _.template($("#task-template").html());
      compiled = compiled({
        data: data
      });
      $(".panel-body[data-status='" + data.current_status + "']").append(compiled);
      setupTasksDragNDrop();
    })
    .fail(function(data) {
      var errors = JSON.parse(data.responseText);
      var compiled = _.template($("#task-errors-template").html());
      compiled = compiled({
        data: errors
      });
      $("#new-task-modal .error-descriptions").html(compiled);
    });
});
var uirec = 0;
var uirstop = 0;

function setupTasksDragNDrop() {
  $(".sortable-panel").sortable({
    connectWith: ".sortable-panel",
    stop: function(event, ui) {
      console.log("receive");
      var itemId = $(ui.item[0]).data("id")
      var newTaskStatus = $(".panel[data-id='" + itemId + "']").parents(".panel-body").data("status");
      var boardId = $("#new-task-modal").data("kanban-board-id");
      var data = {
        current_status: newTaskStatus
      };
      $.ajax({
        url: "/kanban_boards/" + boardId + "/tasks/" + itemId + ".json",
        data: JSON.stringify(data),
        type: 'PATCH',
        contentType: 'application/json',
        processData: false,
        dataType: 'json'
      });

      var order = [];
      $(".sortable-panel[data-status='" + newTaskStatus + "'] .task-draggable").each(function() {
        order.push($(this).data("id"));
      });
      var positionsData = {
        status: newTaskStatus,
        positions: order
      };
      $.post("/kanban_boards/" + boardId + "/tasks/update_positions.json", positionsData);
    }
  }).disableSelection();
}

setupTasksDragNDrop();

$(function() {
  $('[data-toggle="tooltip"]').tooltip()
})
