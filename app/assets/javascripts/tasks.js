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
      console.log("success");
      $('#new-task-modal').modal('hide');
      var compiled = _.template($("#task-template").html());
      compiled = compiled({
        data: data
      });
      $(".panel-body[data-status='" + data.current_status + "']").append(compiled);
      setupTasksDragNDrop();
    })
    .fail(function(data) {
      console.log("error");
      console.log(data);
      var errors = JSON.parse(data.responseText);
      var compiled = _.template($("#task-errors-template").html());
      compiled = compiled({
        data: errors
      });
      $("#new-task-modal .error-descriptions").html(compiled);
    })
    .always(function(data) {
      console.log("finished");
    });
});

function setupTasksDragNDrop() {
  if ($(".task-draggable").data('draggable')) {
    $(".task-draggable").draggable("destroy");
    $(".task-droppable").droppable("destroy");
  }

  $(".task-draggable").draggable({
    revert: "invalid"
  });

  $(".task-droppable").droppable({
    hoverClass: "panel-drop-hover",
    accept: ".task-draggable",
    drop: function(event, ui) {
      var draggableTaskId = $(ui.draggable).data("id");
      var newTaskStatus = $(this).data("status");
      var boardId = $("#new-task-modal").data("kanban-board-id");
      var data = {current_status: newTaskStatus};
      // cloning and appending prevents the revert animation from still occurring
      ui.draggable.clone(true).css('position', 'inherit').appendTo($(this));
      ui.draggable.remove();
      $.ajax({
        url: "/kanban_boards/" + boardId + "/tasks/"+draggableTaskId+".json",
        data: JSON.stringify(data),
        type: 'PATCH',
        contentType: 'application/json',
        processData: false,
        dataType: 'json'
      });
    }
  });
}

setupTasksDragNDrop();

$(function() {
  $('[data-toggle="tooltip"]').tooltip()
})
