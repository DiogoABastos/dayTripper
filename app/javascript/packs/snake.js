const canvas = document.querySelector('.space');
const ctx = canvas.getContext('2d');

const square = 20;
const wagon = document.getElementById('wagon');

let gameState = true;
let moving = false;


function clearCanvas() {
  ctx.fillStyle = "black";
  ctx.fillRect(0, 0, canvas.width, canvas.height);
}

function drawSquare(x, y) {
  ctx.drawImage(wagon, x, y, square, square);
}

function random20Number(min, max) {
  return Math.floor((Math.random() * (max - min + 1) + min) / 20 ) * 20;
}

function restartGame() {
  if (!gameState) {
    snake.parts = [ {x: 120, y: 120}, {x: 100, y: 120}];
    snake.dx = 20;
    snake.dy = 0;
    food.x = random20Number(0, canvas.width - square);
    food.y = random20Number(0, canvas.height - square);
    score.current = 0;
    gameState = true;
  }
}

canvas.addEventListener('click', restartGame);

const food = {
  x: random20Number(0, canvas.width - square),
  y: random20Number(0, canvas.height - square),

  draw() {
    drawSquare(this.x, this.y);
  }
}

const snake = {
  dx: square,
  dy: 0,
  parts: [ {x: 120, y: 120}, {x: 100, y: 120}],

  update() {
    const head = {x: this.parts[0].x + this.dx, y: this.parts[0].y + this.dy};
    this.parts.unshift(head);
    if (this.parts[0].x === food.x && this.parts[0].y === food.y) {
      score.current += 10;

      food.x = random20Number(0, canvas.width - square);
      food.y = random20Number(0, canvas.height - square);

      this.parts.forEach((part) => {
        if (part.x === food.x && part.y === food.y) {
          food.x = random20Number(0, canvas.width - square);
          food.y = random20Number(0, canvas.height - square);
        }
      })

    } else {
      this.parts.pop();
    }

    if (this.parts[0].x > canvas.width - square) {
      this.parts[0].x = 0;
    } else if (this.parts[0].x < 0) {
      this.parts[0].x = canvas.width - square;
    } else if (this.parts[0].y > canvas.height - square) {
      this.parts[0].y = 0;
    } else if (this.parts[0].y < 0) {
      this.parts[0].y = canvas.height - square;
    }

    for (let i = 4; i < this.parts.length; i++) {
      if (this.parts[0].x === this.parts[i].x && this.parts[0].y === this.parts[i].y) {
        gameState = false;
      }
    }
  },

  draw() {
    this.parts.forEach((part) => {
      drawSquare(part.x, part.y);
    })
  }
}

const score = {
  current: 0,

  draw() {
    ctx.fillStyle = 'white';
    ctx.font = '20px Arial'
    ctx.fillText(`Score: ${this.current}`, canvas.width - 120, 20);
  }
}

function direction(e) {
  e.preventDefault();

  const left = 37;
  const up = 38;
  const right = 39;
  const down = 40;

  if (!moving) {
    if (e.keyCode === left && snake.dx !== square) {
      snake.dx = -square;
      snake.dy = 0;
    } else if (e.keyCode === up && snake.dy !== square) {
      snake.dx = 0;
      snake.dy = -square;
    } else if (e.keyCode === right && snake.dx !== -square) {
      snake.dx = square;
      snake.dy = 0;
    } else if (e.keyCode === down && snake.dy !== -square) {
      snake.dx = 0;
      snake.dy = square;
    }
  }

  moving = true;
}

window.addEventListener('keydown', direction);

function update() {
  if (gameState) {
    snake.update();
  }
}

function draw() {
  food.draw();
  snake.draw();
  score.draw();

  if (!gameState) {
    ctx.fillStyle = 'white';
    ctx.font = '20px Arial';
    ctx.fillText('You Lost!', canvas.width / 2 - 50, canvas.height / 2);
    ctx.fillText('Click to Restart', canvas.width / 2 - 70, canvas.height / 2 + 50);
  }
}

function loop() {
  clearCanvas();
  update();
  draw();
  moving = false;
}

function game() {
  let interval = setInterval(loop, 100);
}

game();
