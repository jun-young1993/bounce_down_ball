import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Floor extends BodyComponent {
  Floor({Vector2? position}) : super(renderBody: false);

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(10, 0.5, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(
      shape,
      density: 0.0,
      friction: 0.3,
    );

    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..position = Vector2(10, 25);

    final body = world.createBody(bodyDef)..createFixture(fixtureDef);
    return body;
  }

  @override
  void render(Canvas canvas) {
    // Draw floor
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromLTWH(-10, -0.5, 20, 1),
      paint,
    );
    
    // Draw floor outline
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawRect(
      Rect.fromLTWH(-10, -0.5, 20, 1),
      outlinePaint,
    );
  }
} 