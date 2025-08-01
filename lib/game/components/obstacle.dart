import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

import 'ball.dart';

class Obstacle extends BodyComponent with CollisionCallbacks {
  Obstacle({Vector2? position}) : super(renderBody: false);

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(1, 1, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(
      shape,
      density: 0.0,
      friction: 0.3,
    );

    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..position = Vector2(10, 15);

    final body = world.createBody(bodyDef)..createFixture(fixtureDef);
    return body;
  }

  @override
  void render(Canvas canvas) {
    // Draw obstacle
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromLTWH(-1, -1, 2, 2),
      paint,
    );
    
    // Draw obstacle outline
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawRect(
      Rect.fromLTWH(-1, -1, 2, 2),
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
      // Game over logic can be added here
      print('Ball hit obstacle!');
    }
  }
} 