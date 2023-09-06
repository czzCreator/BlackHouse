import 'package:flame/game.dart';
import 'package:flutter/material.dart';

// Overlay that pops up when the game ends
class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/game_over_overlay.jpg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
