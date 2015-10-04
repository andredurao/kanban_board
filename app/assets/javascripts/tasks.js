$("#new-task-modal-submit").on("click", function(){
  //post to /kanban_boards/:kanban_board_id/tasks
  var boardId = $("#new-task-modal").data("kanban-board-id");
  var formdata = $("#new-task-modal form").serializeArray();
  var data = {};
  $(formdata).each(function(index, obj){
      data[obj.name] = obj.value;
  });

  $.post( "/kanban_boards/"+boardId+"/tasks", data).
    done(function() {
      alert("success");
    })
    .fail(function() {
      alert("error");
    })
    .always(function() {
      alert("finished");
    });

});
