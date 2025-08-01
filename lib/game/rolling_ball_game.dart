import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/timer.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'components/ball.dart';
import 'components/floor.dart';
import 'components/obstacle.dart';
import 'components/bounce_pad.dart';
import 'components/score_manager.dart';

class RollingBallGame extends Forge2DGame with HasCollisionDetection {
  late Ball ball;
  late ScoreManager scoreManager;
  late StreamSubscription<AccelerometerEvent>? accelSub;

  // Game state
  bool isGameOver = false;
  double tiltSensitivity = 15.0;
  Timer? scoreTimer;
  Timer? spawnTimer;
  final Random random = Random();

  RollingBallGame() : super(gravity: Vector2(0, 20));

  @override
  Future<void> onLoad() async {
    // Initialize score manager
    scoreManager = ScoreManager();
    add(scoreManager);

    // Add ball
    ball = Ball();
    add(ball);

    // Add floor
    add(Floor());

    // Add initial obstacles and bounce pads
    _spawnObstacles();

    // Start sensor listening (only on mobile)
    if (Platform.isAndroid || Platform.isIOS) {
      _startSensorListening();
    }

    // Start score timer
    _startScoreTimer();

    // Start spawn timer
    _startSpawnTimer();

    // Show score overlay
    overlays.add('score');
  }

  void _spawnObstacles() {
    // Spawn obstacles at different positions
    add(Obstacle(position: Vector2(5, 8)));
    add(Obstacle(position: Vector2(15, 12)));
    add(Obstacle(position: Vector2(8, 16)));
    add(Obstacle(position: Vector2(18, 20)));

    // Spawn bounce pads
    add(BouncePad(position: Vector2(12, 10)));
    add(BouncePad(position: Vector2(6, 14)));
    add(BouncePad(position: Vector2(16, 18)));
  }

  void _startScoreTimer() {
    scoreTimer = Timer(
      1.0,
      onTick: () {
        if (!isGameOver) {
          scoreManager.addScore(1);
        }
      },
      repeat: true,
    );
  }

  void _startSpawnTimer() {
    spawnTimer = Timer(
      3.0,
      onTick: () {
        if (!isGameOver) {
          _spawnRandomObstacle();
        }
      },
      repeat: true,
    );
  }

  void _spawnRandomObstacle() {
    final x = random.nextDouble() * 20;
    final y = random.nextDouble() * 10 + 5;

    if (random.nextBool()) {
      add(Obstacle(position: Vector2(x, y)));
    } else {
      add(BouncePad(position: Vector2(x, y)));
    }
  }

  void _startSensorListening() {
    try {
      accelSub = accelerometerEvents.listen((AccelerometerEvent event) {
        if (!isGameOver) {
          // Apply tilt force to ball
          final tiltForce = Vector2(event.x * tiltSensitivity, 0);
          ball.applyTilt(tiltForce);
        }
      });
    } catch (e) {
      print('Sensor not available: $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreTimer?.update(dt);
    spawnTimer?.update(dt);
  }

  void gameOver() {
    isGameOver = true;
    accelSub?.cancel();
    scoreManager.gameOver();
    // You can add game over logic here
  }

  @override
  void onRemove() {
    accelSub?.cancel();
    scoreTimer?.stop();
    spawnTimer?.stop();
    super.onRemove();
  }
}
