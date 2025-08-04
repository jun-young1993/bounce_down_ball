import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class BouncePad extends BodyComponent {
  final Vector2? initialPosition;

  BouncePad({Vector2? position}) : initialPosition = position;

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(0.8, 0.1, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(
      shape,
      density: 0.0,
      friction: 0.1,
      restitution: 1.2,
    );

    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..position = initialPosition ?? Vector2(5, 12);

    final body = world.createBody(bodyDef)..createFixture(fixtureDef);
    return body;
  }

  @override
  void render(Canvas canvas) {
    // 노란색 바운스 패드
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(-24, -3, 48, 6), paint);

    // 흰색 테두리
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(Rect.fromLTWH(-24, -3, 48, 6), outlinePaint);
  }
}
