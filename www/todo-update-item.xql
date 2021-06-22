<?xml version="1.0"?>
<queryset>
   <fullquery name="update_task">
      <querytext>
       update todo_item
       set status = :new_status
       where item_id = :item_id
      </querytext>
   </fullquery>
</queryset>