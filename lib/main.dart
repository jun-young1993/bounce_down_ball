import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'game/rolling_ball_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bounce Down Ball',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late RollingBallGame game;

  @override
  void initState() {
    super.initState();
    game = RollingBallGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GameWidget(
        game: game,
        overlayBuilderMap: {
          'score': (context, game) =>
              ScoreOverlay(game: game as RollingBallGame),
        },
      ),
    );
  }
}

class ScoreOverlay extends StatelessWidget {
  final RollingBallGame game;

  const ScoreOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Score display
        Positioned(
          top: 50,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: game.scoreManager.scoreNotifier,
                  builder: (context, score, child) {
                    return Text(
                      'Score: $score',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 4),
                ValueListenableBuilder<int>(
                  valueListenable: game.scoreManager.highScoreNotifier,
                  builder: (context, highScore, child) {
                    return Text(
                      'High Score: $highScore',
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        // Instructions
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How to Play:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '• Tilt your device to move the ball left/right',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  '• Avoid red obstacles',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  '• Hit yellow pads to bounce higher',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  '• Collect points by surviving longer',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
