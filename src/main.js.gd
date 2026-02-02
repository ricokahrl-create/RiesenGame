const canvas = document.getElementById("game");
const ctx = canvas.getContext("2d");

function resize() {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
}
window.addEventListener("resize", resize);
resize();

function loop() {
  // Platzhalter: Hintergrund + Text
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.fillText("RiesenGame läuft ✅", 20, 30);

  requestAnimationFrame(loop);
}
loop();
