<master src="master">
<div class="row">
    <div class="col-md-12">
        <table class="table" id="myTable" width="100%">
            <thead class="bg-warning">
                <tr>
                    <td scope="col">Task Title</td>
                    <td scope="col">Status</td>
                    <td scope="col">Due Date</td>
                    <td scope="col">Options</td>
                </tr>
            </thead>
            <tbody>
                <multiple name="todo_list_mr">
                        <tr scope="row">
                            <td>@todo_list_mr.title@</td>
                            <td>
                                <switch @todo_list_mr.status@>
                                    <case value="p">
                                            Pending
                                    </case>
                                    <case value="c">
                                            Completed
                                    </case>
                                    <case value="x">
                                            Canceled
                                    </case>
                                    <default>
                                            Unknow
                                    </default>
                                </switch>
                            </td>
                            <td>@todo_list_mr.due_date@</td>
                            <td width="50px">
                                <div class="btn-group" role="group" aria-label="Options">
                                    @todo_list_mr.delete_button;noquote@
                                    @todo_list_mr.complete_button;noquote@
                                    @todo_list_mr.cancel_button;noquote@
                                </div>
                            </td>
                        </tr>  
                </multiple>
            </tbody>    
        </table>
    </div>
</div>
<div class="row"> 
    <div class="col-md-12 text-center">
         <!-- Button trigger modal -->
            <button type="button" class="btn btn-warning" onclick="new_task()">
              Add New Task
            </button>
    </div>
</div>
<!-- Modal -->
<div id="dialog" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">Add new task</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body"  id="dialog-body">
        
      </div>
    </div>
  </div>
</div>
<div id="delete" class="modal">
    <p>Delete this item?</p>
</div>
<script>
    $(document).ready(function() {
        $('#myTable').DataTable({
            responsive: true
        });
    });

    function new_task() {
        $('#dialog-body').load('@form_url@', function() {
             // alert('Load was performed.');
        });
        $('#dialog').modal({show:true});
    }

    async function complete_item(item_id) {
        $.ajax({
            type: "GET",
            url: "@update_url@?item_id="+item_id+"&new_status=c",
            success: function (data, textStatus, jqXHR) {
                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error Loading: "+errorThrown)
            },
            always: function (jqXHR, textStatus, errorThrown) {
                alert("always Loading: " + jqXHR)
            },
        });
        setTimeout(function() { 
            window.location.reload();
        }, 500);
    }

    function cancel_item(item_id) {
        $.ajax({
            type: "GET",
            url: "@update_url@?item_id="+item_id+"&new_status=x",
            success: function (data, textStatus, jqXHR) {
                setTimeout(function() { 
                    Swal.fire("success","success","success")
                    window.location.reload();
                }, 1000);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error Loading: "+errorThrown)
            }
        });
        setTimeout(function() { 
            window.location.reload();
        }, 500);
    } 

    function delete_item( item_id ) {
        Swal.fire({
            title: 'Do you want to delete this item?',
            showCancelButton: true,
            confirmButtonText: `Yes`,
            icon: 'warning',
            }).then((result) => {
                if (result.isConfirmed) {
                   post_delete(item_id);
                }
            })  
    }

    function post_delete(item_id) {
        $.ajax({
            type: "POST",
            url: "@delete_url@",
            data: {item_id: item_id},
            success: function (data, textStatus, jqXHR) {
                window.location.reload();
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error Loading: "+errorThrown)
            }
        });
        setTimeout(function() { 
            window.location.reload();
        }, 500);
    }

</script>