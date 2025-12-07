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

function bindShowQrCode() {
  $('.show-qr-code').on('click', function (e) {
    e.preventDefault();
    $.get($(this).attr('href'));
  });
}

function makeQrCode() {
  const qrContainer = document.getElementById('qrcode');
  if (qrContainer && qrContainer.children.length === 0) {
    new QRCode(qrContainer, {
      text: qrContainer.dataset.shareUrl,
      width: qrContainer.dataset.size === 'big' ? 500 : 200,
      height: qrContainer.dataset.size === 'big' ? 500 : 200,
      colorDark: '#667eea',
      colorLight: '#ffffff',
      correctLevel: QRCode.CorrectLevel.H
    });
  }
}

$(document).on('turbo:load', function () {
  bindDrawNumber();
  bindPlayerLink();
  bindShowQrCode();
  makeQrCode();
});
