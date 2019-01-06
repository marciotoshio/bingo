//= require cable
//= require_self
//= require_tree .

function createSubscription(gameId) {
  options = {
    channel: "GameChannel",
    game_id: gameId
  };

  App.cable.subscriptions.create(options, {
    received: function(data) {
      switch(data.action) {
        case 'set_last_number':
          setLastNumber(data.last_number);
        case 'reset':
          reset();
        case 'new_player':
          addNewPlayer(data.player);
      }
    }
  });
}

function setLastNumber(lastNumber) {
  $(".last-number").text(lastNumber);
  $('#num_' + lastNumber).addClass('selected');
}

function reset() {
  window.location.reload(false);
}

function addNewPlayer(player) {
  var li = $('<li />');
  var a = $('<a class="player-link" href="' + player.url + '"/>');
  a.text(player.name);
  li.append(a);
  $('.players').append(li);
}

$(document).on('turbolinks:load', function() {
  if($('#game_id').val() != null) {
    createSubscription($('#game_id').val());
  }
});
