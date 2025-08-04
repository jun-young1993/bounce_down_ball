import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Ball extends BodyComponent {
  final Vector2? initialPosition;
  static const double radius = 0.3;

  Ball({Vector2? position}) : initialPosition = position;

  @override
  Body createBody() {
    final shape = CircleShape()..radius = radius;
    final fixtureDef = FixtureDef(
      shape,
      density: 1.0,
      friction: 0.3,
      restitution: 0.6,
    );

    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = initialPosition ?? Vector2(5, 2);

    final body = world.createBody(bodyDef)..createFixture(fixtureDef);
    return body;
  }

  @override
  void render(Canvas canvas) {
    // 파란색 공 - 더 크게
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset.zero, 25, paint);

    // 흰색 테두리
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(Offset.zero, 25, outlinePaint);
  }

  void applyForce(Vector2 force) {
    body.applyForce(force);
  }
}
