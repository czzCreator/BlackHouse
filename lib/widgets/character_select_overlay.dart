import 'package:flame/game.dart';
import 'package:flutter/material.dart';

//主菜单界面点击 开始游戏后--- 选择人物角色选择画面
// Overlay that appears for the character select menu
class CharacterSelectOverlay extends StatefulWidget {
  const CharacterSelectOverlay(this.game, {super.key});

  final Game game;

  @override
  State<CharacterSelectOverlay> createState() => _CharacterSelectOverlayState();
}

class _CharacterSelectOverlayState extends State<CharacterSelectOverlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/game_option_page/bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
