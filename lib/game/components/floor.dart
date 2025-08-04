import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Floor extends BodyComponent {
  final Vector2? initialPosition;

  Floor({Vector2? position}) : initialPosition = position;

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(5, 0.2, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(shape, density: 0.0, friction: 0.5);

    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..position = initialPosition ?? Vector2(5, 15);

    final body = world.createBody(bodyDef)..createFixture(fixtureDef);
    return body;
  }

  @override
  void render(Canvas canvas) {
    // 바닥을 투명하게 만들기 위해 렌더링하지 않음
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(-150, -6, 300, 12), paint);

    // 흰색 테두리
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(Rect.fromLTWH(-150, -6, 300, 12), outlinePaint);
  }
}
