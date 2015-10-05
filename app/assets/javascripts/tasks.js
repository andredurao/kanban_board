$("#new-task-modal-submit").on("click", function(){

  var boardId = $("#new-task-modal").data("kanban-board-id");
  var formdata = $("#new-task-modal form").serializeArray();
  var data = {};
  $(formdata).each(function(index, obj){
      data[obj.name] = obj.value;
  });

  $.post( "/kanban_boards/"+boardId+"/tasks.json", data).
    done(function() {
      console.log("success");
      $('#new-task-modal').modal('hide');
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("finished");
      var compiled = _.template($("#task-template").html());
      compiled = compiled({data: data});
      $(".panel-body[data-status='"+data["[task][current_status]"]+"']").append(compiled);
    });
});

$("button[data-target='#new-task-modal']").on("click", function(){
  var currentStatus = $(this).data("status");
  $("#new-task-modal input[name='[task][current_status]']").val(currentStatus);
  $('#new-task-modal').modal();
});

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
