import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

import 'ball.dart';

class BouncePad extends BodyComponent with CollisionCallbacks {
  BouncePad({Vector2? position}) : super(renderBody: false);

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(2, 0.3, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(
      shape,
      density: 0.0,
      friction: 0.1,
      restitution: 1.5, // 높은 반동
    );

    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..position = Vector2(10, 20);

    final body = world.createBody(bodyDef)..createFixture(fixtureDef);
    return body;
  }

  @override
  void render(Canvas canvas) {
    // Draw bounce pad
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromLTWH(-2, -0.3, 4, 0.6),
      paint,
    );
    
    // Draw bounce pad outline
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawRect(
      Rect.fromLTWH(-2, -0.3, 4, 0.6),
      outlinePaint,
    );
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    
    if (other is Ball) {
      // Apply extra bounce force
      (other as Ball).body.applyLinearImpulse(Vector2(0, -20));
      print('Ball bounced on pad!');
    }
  }
} 