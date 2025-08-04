import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Obstacle extends BodyComponent {
  final Vector2? initialPosition;

  Obstacle({Vector2? position}) : initialPosition = position;

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(0.4, 0.4, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(shape, density: 0.0, friction: 0.3);

    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..position = initialPosition ?? Vector2(5, 8);

    final body = world.createBody(bodyDef)..createFixture(fixtureDef);
    return body;
  }

  @override
  void render(Canvas canvas) {
    // 빨간색 장애물
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(-12, -12, 24, 24), paint);

    // 흰색 테두리
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(Rect.fromLTWH(-12, -12, 24, 24), outlinePaint);
  }
}
