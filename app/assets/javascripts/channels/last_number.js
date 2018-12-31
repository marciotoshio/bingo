App.last_number = App.cable.subscriptions.create('LastNumberChannel', {
  received: function(data) {
    $(".last-number").text(data.last_number);
  }
});
