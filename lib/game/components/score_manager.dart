import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

class ScoreManager extends Component {
  int _score = 0;
  int _highScore = 0;
  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> highScoreNotifier = ValueNotifier<int>(0);
  
  int get score => _score;
  int get highScore => _highScore;
  
  void addScore(int points) {
    _score += points;
    scoreNotifier.value = _score;
    
    // Update high score
    if (_score > _highScore) {
      _highScore = _score;
      highScoreNotifier.value = _highScore;
    }
  }
  
  void resetScore() {
    _score = 0;
    scoreNotifier.value = _score;
  }
  
  void gameOver() {
    // Save high score logic can be added here
    print('Game Over! Final Score: $_score, High Score: $_highScore');
  }
  
  @override
  void onRemove() {
    scoreNotifier.dispose();
    highScoreNotifier.dispose();
    super.onRemove();
  }
} 