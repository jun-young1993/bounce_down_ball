import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

import 'obstacle.dart';
import 'bounce_pad.dart';

class Ball extends BodyComponent with CollisionCallbacks {
  static const double radius = 0.5;

  Ball({Vector2? position}) : super(renderBody: false);

  @override
  Body createBody() {
    final shape = CircleShape()..radius = radius;
    final fixtureDef = FixtureDef(
      shape,
      density: 1.0,
      friction: 0.3,
      restitution: 0.3, // 일반 반동
    );

    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = Vector2(10, 5)
      ..linearDamping = 0.1; // 공기 저항

    final body = world.createBody(bodyDef)..createFixture(fixtureDef);
    return body;
  }

  @override
  void render(Canvas canvas) {
    // Draw ball
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset.zero,
      radius * 10, // Scale for rendering
      paint,
    );

    // Draw ball outline
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(Offset.zero, radius * 10, outlinePaint);
  }

  void applyTilt(Vector2 force) {
    body.applyForce(force);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    // Handle collision with different components
    if (other is Obstacle) {
      // Game over or score penalty
      print('Hit obstacle!');
    } else if (other is BouncePad) {
      // Apply bounce effect
      body.applyLinearImpulse(Vector2(0, -15));
      print('Bounced!');
    }
  }
}
