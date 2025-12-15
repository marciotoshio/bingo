function playStartAudio(lang) {
  const startAudio = new Audio(`/audios/${lang}/start.mp3`);
  startAudio.play();
}
window.playStartAudio = playStartAudio;

async function playBingoAudio(number, lang) {
  const phraseIndex = Math.floor(Math.random() * 52);

  // Create audio objects
  const phraseAudio = new Audio(`/audios/${lang}/phrase${phraseIndex}.mp3`);
  const numberAudio = new Audio(`/audios/${lang}/${number}.mp3`);

  // Play sequentially
  await playAudio(phraseAudio);
  await playAudio(numberAudio);
}

// Helper to await audio finish
function playAudio(audio) {
  return new Promise((resolve) => {
    audio.play();
    audio.addEventListener("ended", resolve);
  });
}

window.playBingoAudio = playBingoAudio;
