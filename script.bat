// Game Constants
const GAME_WIDTH = 800;
const GAME_HEIGHT = 600;
const PLAYER_SPEED = 5;
const ENEMY_SPEED = 3;
const BULLET_SPEED = 8;

// Game Objects
let player;
let enemies = [];
let bullets = [];

// Player Object
class Player {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    this.width = 50;
    this.height = 50;
    this.color = 'blue';
  }

  draw() {
    ctx.fillStyle = this.color;
    ctx.fillRect(this.x, this.y, this.width, this.height);
  }

  update() {
    if (keys[37] && this.x > 0) {
      this.x -= PLAYER_SPEED;
    }
    if (keys[39] && this.x < GAME_WIDTH - this.width) {
      this.x += PLAYER_SPEED;
    }
    if (keys[32]) {
      bullets.push(new Bullet(this.x + this.width / 2, this.y));
    }
  }
}

// Enemy Object
class Enemy {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    this.width = 30;
    this.height = 30;
    this.color = 'red';
  }

  draw() {
    ctx.fillStyle = this.color;
    ctx.fillRect(this.x, this.y, this.width, this.height);
  }

  update() {
    this.y += ENEMY_SPEED;
    if (this.y > GAME_HEIGHT) {
      this.y = -this.height;
      this.x = Math.random() * (GAME_WIDTH - this.width);
    }
  }
}

// Bullet Object
class Bullet {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    this.width = 5;
    this.height = 10;
    this.color = 'yellow';
  }

  draw() {
    ctx.fillStyle = this.color;
    ctx.fillRect(this.x, this.y, this.width, this.height);
  }

  update() {
    this.y -= BULLET_SPEED;
    if (this.y < 0) {
      bullets.splice(bullets.indexOf(this), 1);
    }
  }
}

// Game Initialization
function init() {
  player = new Player(GAME_WIDTH / 2 - 25, GAME_HEIGHT - 60);
  for (let i = 0; i < 5; i++) {
    enemies.push(new Enemy(Math.random() * (GAME_WIDTH - 30), Math.random() * GAME_HEIGHT));
  }
}

// Game Loop
function gameLoop() {
  ctx.clearRect(0, 0, GAME_WIDTH, GAME_HEIGHT);
  
  player.update();
  player.draw();

  bullets.forEach(bullet => {
    bullet.update();
    bullet.draw();
  });

  enemies.forEach(enemy => {
    enemy.update();
    enemy.draw();

    if (
      player.x < enemy.x + enemy.width &&
      player.x + player.width > enemy.x &&
      player.y < enemy.y + enemy.height &&
      player.y + player.height > enemy.y
    ) {
      // Collision occurred
      // Game Over
      alert("Game Over!");
      document.location.reload();
    }

    bullets.forEach(bullet => {
      if (
        bullet.x < enemy.x + enemy.width &&
        bullet.x + bullet.width > enemy.x &&
        bullet.y < enemy.y + enemy.height &&
        bullet.y + bullet.height > enemy.y
      ) {
        // Collision occurred
        // Remove enemy and bullet
        enemies.splice(enemies.indexOf(enemy), 1);
        bullets.splice(bullets.indexOf(bullet
