import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/ball.dart';
import 'components/floor.dart';
import 'components/obstacle.dart';
import 'components/bounce_pad.dart';
import 'components/score_manager.dart';

class RollingBallGame extends Forge2DGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  late Ball ball;
  late ScoreManager scoreManager;

  RollingBallGame() : super(gravity: Vector2(0, 10));

  @override
  Future<void> onLoad() async {
    // 세로 모바일 화면에 맞는 카메라 설정 - 더 넓은 뷰포트
    camera.viewfinder.visibleGameSize = Vector2(size.x / 2, 300);
    camera.viewfinder.position = Vector2(6, 10);

    // 점수 관리자
    scoreManager = ScoreManager();
    add(scoreManager);

    // 공 (화면 하단 정중앙에, 바닥에서 충분히 위)
    ball = Ball(position: Vector2(size.x / 2, size.y - 100));
    add(ball);

    // 바닥 (화면 하단에)
    add(Floor(position: Vector2(size.x / 2, size.y - 50)));

    // 테스트용 장애물들 - 공 위쪽에 배치
    add(Obstacle(position: Vector2(3, 10)));
    add(Obstacle(position: Vector2(9, 8)));
    add(BouncePad(position: Vector2(size.x / 2, size.y - 60)));

    // 점수 오버레이 표시
    // overlays.add('score');

    print(
      'Game loaded successfully! Camera: ${camera.viewfinder.visibleGameSize}',
    );
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final force = Vector2.zero();

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      force.x = -30;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      force.x = 30;
    }

    if (force.x != 0) {
      ball.applyForce(force);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 공이 화면 밖으로 나가면 게임 오버
    // if (ball.body.position.y > 22) {
    //   gameOver();
    // }
  }

  void gameOver() {
    print('Game Over!');
    scoreManager.gameOver();
  }
}
