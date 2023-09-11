import 'package:flame/components.dart';

import '../black_house_game.dart';

// It won't be a detailed section of the codelab, as its not Flame specific
// 用于管理游戏中的一些 状态信息等
class GameManager extends Component with HasGameRef<BlackHouseGame> {
  GameManager();

  // The character that the player has selected, 默认初始化为 littleBoyPeter
  Character character = Character.littleBoyPeter;

  //游戏阶段状态的记录 默认刚开始处于 intro 状态(引导流程)
  GameState state = GameState.intro;

  bool get isGameOver => state == GameState.gameOver;
  bool get isPlaying => state == GameState.playing;
  bool get isCharacterSelecting => state == GameState.characterSelecting;
  bool get isNetworkTeaming => state == GameState.networkTeaming;
  bool get isIntro => state == GameState.intro;

  void reset() {
    state = GameState.intro;
  }

  void selectCharacter(Character selectedCharacter) {
    character = selectedCharacter;
  }
}

//可能有的游戏流程状态
enum GameState { intro, networkTeaming, characterSelecting, playing, gameOver }
