import consumer from "channels/consumer"
import $ from "jquery"

function createSubscription(gameId) {
  const options = {
    channel: "GameChannel",
    game_id: gameId
  };

  consumer.subscriptions.create(options, {
    received: function (data) {
      switch (data.action) {
        case 'set_last_number':
          setLastNumber(data.last_number, data.raw_last_number);
          break;
        case 'reset':
          reset();
          break;
        case 'new_player':
          addNewPlayer(data.player);
          break;
      }
    }
  });
}

function setLastNumber(lastNumber, rawLastNumber) {
  $(".last-number").text(lastNumber);
  $('#num_' + rawLastNumber).addClass('selected');
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

$(document).on('turbo:load', function () {
  if ($('#game_id').val() != null) {
    createSubscription($('#game_id').val());
  }
});
