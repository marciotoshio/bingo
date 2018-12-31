App.reset = App.cable.subscriptions.create('ResetChannel', {
  received: function(data) {
    window.location.reload(false);
  }
});
