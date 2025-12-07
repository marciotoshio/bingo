import $ from "jquery"

function bindDrawNumber() {
  $('.draw-number').on('click', function (e) {
    e.preventDefault();
    $.get($(this).attr('href'));
  });
}

function bindPlayerLink() {
  $('.player-link').on('click', function (e) {
    e.preventDefault();
    $('.player-card').load($(this).attr('href'));
  });
}

$(document).on('turbo:load', function () {
  bindDrawNumber();
  bindPlayerLink();
});
