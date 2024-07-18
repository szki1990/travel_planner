// Example using jQuery for Ajax submission
$('input[type="checkbox"]').change(function() {
  var itemId = $(this).data('item-id');
  var isChecked = $(this).prop('checked');

  $.ajax({
    url: '/toggle_completed',
    method: 'PATCH',
    data: { id: itemId, completed: isChecked },
    success: function(response) {
      console.log('Item updated successfully');
    },
    error: function(xhr, status, error) {
      console.error('Error updating item:', error);
    }
  });
});
