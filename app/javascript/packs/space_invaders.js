const canvas = document.querySelector('.space');
const ctx = canvas.getContext('2d');

const square = 20;
const cols = 8;
const rows = 4;
const ajustOne = 16 / 2;
let playerBullets = [];
let enemyBullets = [];
let frames = 0;
let interval;
let gameState = true;
let win;

function drawSquare(x, y, color) {
  ctx.fillStyle = color;
  ctx.strokeStyle = 'black';
  ctx.fillRect(x, y, square, square);
  ctx.strokeRect(x, y, square, square);
}

function clearBoard() {
  ctx.fillStyle = 'black';
  ctx.fillRect(0, 0, canvas.width, canvas.height);
}

function selectRandomEnemy(array) {
  return array[Math.floor(Math.random() * array.length)];
}

function sortByX(array) {
  return array.sort((a, b) => a.x - b.x);
}

function Enemy(x, y) {
  this.x = x;
  this.y = y;
  this.w = square;
  this.h = square;
}

function firstWaveEnemies() {
  let wave = [];
  for (let r = 1; r < rows; r++) {
    for (let c = 1; c < cols; c++) {
      wave.push(new Enemy(c * 38, r * 55));
    }
  }

  return wave;
}

function restartGame() {
  if (!gameState) {
    frames = 0;
    playerBullets = [];
    enemyBullets = [];
    player.restart();
    enemies.restart();
    gameState = true;
  }
}

function destroy(array, element) {
  return array.splice(array.indexOf(element), 1);
}

function drawText(x, y, text) {
  ctx.font = '15px Arial';
  ctx.fillStyle = 'white';
  ctx.fillText(text, x, y);
}

function collide(one, two) {
  const oneLeft = one.x;
  const oneRight = one.x + one.w;
  const oneTop = one.y;
  const oneBot = one.y + one.h;
  const twoLeft = two.x;
  const twoRight = two.x + two.w;
  const twoTop = two.y;
  const twoBot = two.y + two.h;

  return oneRight > twoLeft && oneLeft < twoRight && oneBot > twoTop && oneTop < twoBot
}

function nFrames(n) {
  return frames % n === 0;
}

const enemies = {
  firstWave: firstWaveEnemies(),
  speed: 2,
  fall: 5,

  bulletHit() {
    this.firstWave.forEach((enemy) => {
      playerBullets.forEach((bullet) => {
        if (collide(bullet, enemy)) {
          destroy(this.firstWave, enemy);
          destroy(playerBullets, bullet);
        }
      });
    });
  },

  enemyBulletHit() {
    enemyBullets.forEach((bullet) => {
      if (collide(bullet, player)) {
        gameState = false;
        win = false;
      }
    });
  },

  update() {
    if (this.firstWave.length === 0) {
      gameState = false;
      win = true;
    }

    this.firstWave.forEach((enemy) => {
      if (collide(enemy, player)) {
        gameState = false;
        win = false;
      }
    });


    enemyBullets.forEach((bullet) => {
      if (bullet.y + bullet.h < 0 || bullet.y > canvas.height) {
        destroy(enemyBullets, bullet);
      }
    });

    this.bulletHit();
    this.enemyBulletHit();

    if (this.firstWave.length > 0) {
      this.firstWave.forEach((enemy) => {
        enemy.x += this.speed;
      });
      this.leftmostEnemy = sortByX(this.firstWave)[0];
      this.rightmostEnemy = sortByX(this.firstWave)[this.firstWave.length - 1];
      if (this.leftmostEnemy.x < 0 || this.rightmostEnemy.x + this.rightmostEnemy.w > canvas.width) {
        this.speed *= -1;
        this.firstWave.forEach((enemy) => {
          enemy.y += this.fall;
        });
      }

      if (nFrames(10)) {
        const randomEnemy = selectRandomEnemy(this.firstWave);
        enemyBullets.push(new Bullet(randomEnemy.x + randomEnemy.w / 2, randomEnemy.y + randomEnemy.h / 2, 4, 'red'));
      }
    }

  },

  draw() {
    this.firstWave.forEach((enemy) => {
      drawSquare(enemy.x, enemy.y, 'red');
    });

    drawText(200, 30, `Enemies left: ${this.firstWave.length}`);
},

restart() {
  this.firstWave = firstWaveEnemies();
  this.speed = 2;
  this.fall = 20;
}
}

const player = {
  x: canvas.width / 2 - square,
  y: canvas.height - square / 2,
  w: square * 2,
  h: square / 2,
  speed: 0,

  moveLeft() {
    this.speed = -4;
  },

  moveRight() {
    this.speed = 4;
  },

  stopMove() {
    this.speed = 0;
  },

  fire() {
    playerBullets.push(new Bullet(this.x + this.w / 2, this.y + this.h / 2, -4, 'white'));
  },

  update() {
    this.x += this.speed;

    if (this.x + this.w / 2 > canvas.width) {
      this.x = canvas.width - this.w / 2;
    } else if (this.x + this.w / 2 < 0) {
      this.x = 0 - this.w / 2;
    }

    playerBullets.forEach((bullet) => {
      if (bullet.y + bullet.h < 0 || bullet.y > canvas.height) {
        destroy(playerBullets, bullet);
      }
    });
  },

  draw() {
    ctx.fillStyle = 'white';
    ctx.fillRect(this.x, this.y, this.w, this.h);
  },

  restart() {
    this.x = canvas.width / 2 - square;
    this.y = canvas.height - square / 2;
    this.w = square * 2;
    this.h = square / 2;
    this.speed = 0;
  }
}

function Bullet(x, y, speed, color) {
  this.x = x;
  this.y = y;
  this.w = 3;
  this.h = 6;
  this.speed = speed;
  this.color = color;

  this.update = function() {
    this.y += this.speed;
  }

  this.draw = function() {
    ctx.fillStyle = this.color;
    ctx.fillRect(this.x, this.y, this.w, this.h);
  }
}

function movePlayer(e) {
  e.preventDefault();
  const left = 37;
  const right = 39;

  if (e.keyCode === left) {
    player.moveLeft();
  } else if (e.keyCode === right) {
    player.moveRight();
  }
}

function cancelMovePlayer(e) {
  e.preventDefault();
  const left = 37;
  const right = 39;

  if (e.keyCode === left || e.keyCode === right) {
    player.stopMove();
  }
}

function playerFire(e) {
  e.preventDefault();
  const space = 32;

  if (e.keyCode === space) {
    player.fire();
  }
}

window.addEventListener('keydown', movePlayer);
window.addEventListener('keyup', cancelMovePlayer);
window.addEventListener('keyup', playerFire);
canvas.addEventListener('click', restartGame);

function update() {
  if (gameState) {
    if (playerBullets) {
      playerBullets.forEach(bullet => bullet.update());
    }
    if (enemyBullets) {
      enemyBullets.forEach(bullet => bullet.update());
    }
    enemies.update();
    player.update();
  }
}

function draw() {
  clearBoard();
  enemies.draw();
  if (playerBullets) {
    playerBullets.forEach(bullet => bullet.draw());
  }
  if (enemyBullets) {
    enemyBullets.forEach(bullet => bullet.draw());
  }
  player.draw();

  if (!gameState) {
    drawText(120, 200, 'Click to restart');
    if (win) {
      drawText(130, 180, 'You Won!');
    } else {
      drawText(130, 180, 'You Lost!');
    }
  }
}

function game() {
    update();
    draw();
    frames++;
}

function main() {
  interval = setInterval(game, 50);
}

main();
