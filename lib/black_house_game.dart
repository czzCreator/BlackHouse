// Copyright 2022 The Czz/WanChao Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import './world.dart';

//桌游默认有 12 个可供选择的角色 (相似的人物有一对 ,共6对)
//1. Missy Dubourde - 金发碧眼的年轻女子,看起来漂亮又阳光
/* **********  Missy Dubourde  **********
1. Missy Dubourde是一个金发碧眼的年轻女子,看起来漂亮又阳光。
2. 她有一头长长的金色秀发,是这个游戏里的明星人物之一。
3. Missy Dubourde善于与人打交道,可以更容易获取其他玩家的帮助。
4. 在游戏中,Missy Dubourde的速度属性很高,可以更快逃脱猎人的追捕。
5. 但Missy Dubourde的生命值较低,需要靠队友支持才能活到最后。
6. Missy Dubourde擅长运用周围的环境来躲避猎人,她可以临时 blockade 掉一些道路。
7. 如果Missy Dubourde死去,全队的移动速度会降低,所以保护她也很重要。
8. Missy Dubourde有一个特殊技能“闪光弹”,可以临时致盲猎人。
9. 这个角色给人一种活力四射的感觉,是游戏迷的最爱之一。
 *****************************************/

//2. Zoe Ingstrom - 20出头的年轻女孩,看起来很可爱
/* ********** Zoe Ingstrom  **********
1. Zoe Ingstrom是一个20出头的年轻女孩,看起来很可爱。
2. 她有一头短发,是这个游戏里的明星人物之一。
3. Zoe Ingstrom善于与人打交道,可以更容易获取其他玩家的帮助。
4. 在游戏中,Zoe Ingstrom的速度属性很高,可以更快逃脱猎人的追捕。
5. 但Zoe Ingstrom的生命值较低,需要靠队友支持才能活到最后。
6. Zoe Ingstrom擅长运用周围的环境来躲避猎人,她可以临时 blockade 掉一些道路。
7. 如果Zoe Ingstrom死去,全队的移动速度会降低,所以保护她也很重要。
8. Zoe Ingstrom有一个特殊技能“闪光弹”,可以临时致盲猎人。
9. 这个角色给人一种活力四射的感觉,是游戏迷的最爱之一。
 *****************************************/

//3. Professor Longfellow - 一位聪明的老学者
/* ********** Professor Longfellow  **********
1. Professor Longfellow是一位聪明的老学者,他的形象是一个白发苍苍的老人。
2. 他的性格沉稳,喜欢独自思考,不太善于与人交流。
3. 在游戏中,他是一个重要的支持型角色。他可以帮助其他玩家恢复生命值。
4. 他的生命值较高,可以承担一些风险,但他的移动速度较慢。
5. Professor Longfellow擅长使用道具,他可以在地图上放置一些陷阱。
6. 如果Professor Longfellow死亡,全队的生命值会降低,所以保护他也很重要。
7. Professor Longfellow的特殊技能是“烟雾弹”,可以让大家暂时脱离险境。
8. 这个角色给人一种智慧的感觉,是游戏迷的最爱之一。
 *****************************************/

//4. Father Rhinehardt - 一位年长的神父
/* ********** Father Rhinehardt  **********
1. Father Rhinehardt是一位年长的神父,他的形象是一个白发苍苍的老人。
2. 他的性格沉稳,喜欢独自思考,不太与人交流。
3. 在游戏中,他是一个重要的支持型角色。他可以帮助其他玩家恢复生命值。
4. 他的生命值较高,可以承担一些风险,但他的移动速度较慢。
5. Father Rhinehardt擅长使用道具,他可以在地图上放置一些陷阱。
6. 如果Father Rhinehardt死亡,全队的生命值会降低,所以保护他也很重要。
7. Father Rhinehardt的特殊技能是“烟雾弹”,可以让大家暂时脱离险境。
8. 这个角色给人一种智慧的感觉,是游戏迷的最爱之一。
 *****************************************/

//5. Heather Granville - 一个外向开朗的金发熟女
/* ********** Heather Granville  **********
1. Heather是一个外向开朗的金发熟女,喜欢与朋友聚会玩乐。
2. 她有一头及腰的长发,是这个游戏中的性感明星之一。
3. Heather很会照顾别人的感受,是一个负责任的好朋友。
4. 在游戏中,她拥有很高的生命值,是队伍中的“Tank”角色。
5. Heather有一个强大的技能“破门”,可以使她一击打破门窗。
6. 她的速度不快,但力量很高,可以移开一些障碍物。
7. Heather最擅长面对面与猎人对峙,她可以阻挡猎人的追击。
8. 如果Heather牺牲,全队生命值恢复速度会降低。
9. 这个角色给人一种可靠、坚强的感觉,是一个很有魅力的人物。
 *****************************************/

//6. Jenny LeClerc - 一个文静内敛的女孩
/* ********** Jenny LeClerc  **********
1. Jenny是一个看起来文静内敛的女孩,有一头及腰长发。
2. 她性格细心内向,善于观察周围环境的细节。
3. 在游戏中,Jenny担任侦察兵的角色,擅长发现隐藏物品。
4. 她有一个独特技能“寻宝”,可以提高找到稀有物品的概率。
5. Jenny的生命值不高,需要队友保护。但速度快,逃跑能力强。
6. 她是队伍中的智囊型人物,擅长制定反击猎人的策略。
7. Jenny找到的隐藏物品可用于装备队友或恢复生命。
8. 如果Jenny牺牲,队伍智力技能将会减弱。
9. Jenny给人一种神秘而聪慧的感觉,是个可靠的战友。
10. 她的存在为游戏加入了更多探索和策略元素。
 *****************************************/

//7. Ox Bellows - 一个高大强壮的男孩
/* ********** Vivian Lopez  **********
1. Ox是一个高大强壮的男孩,有一头短短的金色头发。
2. 他性格乐天开朗,给人一种阳光运动员的感觉。
3. 在游戏中,Ox是队伍中的主战力量型角色。
4. 他拥有极高的生命值,可以承受猎人的重创。
5. Ox的特殊技能是“冲锋”,可以对猎人造成额外伤害。
6. 他还可以使用“掩护”技能,暂时保护队友免受攻击。
7. Ox的速度不快,但可以推开一些障碍物清理道路。
8. 如果Ox牺牲,全队受到的伤害都会提高。
9. Ox给人一种乐观豁达的感觉,是队伍中的重要支柱。
10. 他经常用乐观的话语鼓舞其他队友。
 *****************************************/

//8. Darrin "Flash" Williams - 一个身材高瘦的黑人青年
/* ********** Darrin "Flash" Williams  **********
1. Darrin是一个身材高瘦的黑人青年,因跑得很快而有“Flash”的外号。
2. 他性格随和开朗,并有很好的运动天赋。
3. 在游戏中,Darrin凭借极快的速度承担诱导和误导猎人的任务。
4. 他有一个“疾驰”的特殊技能,可以极快逃离猎人的追捕。
5. Darrin还会使用“诱饵”技能来吸引猎人的注意力。
6. 他的生命值并不高,需要队友保护。
7. 如果Darrin牺牲,全队移动速度会下降。
8. Darrin经常用幽默来调节队伍气氛。
9. 他是队伍的闪电,对于脱离险境至关重要。
10. Darrin给人一种轻松机智的感觉,是一个很有魅力的角色。
 *****************************************/

//9. Peter Akimoto - 一个身材普通的亚裔小男孩
/* ********** Peter Akimoto  **********
1. Peter是一个身材普通的亚裔小男孩,性格稍微内向,但很聪明。
2. 他喜欢研究各种小装置,是个技术发烧友。
3. 在游戏中,Peter是队伍中的智囊和装备制造角色。
4. 他有一个“制造”的特殊技能,可以制作各种道具。
5. Peter还会使用“破解”技能来解锁隐藏区域或密码门。
6. 他的生命值不高,需要队友保护。
7. 如果Peter牺牲,队伍智力技能会减弱。
8. Peter不善言谈,但头脑冷静,经常提供建议。
9. 他制作的装备对整个队伍的生存很关键。
10. Peter给人一种沉静聪慧的感觉,是个可靠的战友。
 *****************************************/

//10. Brandon Jaspers - 一个身材高大的男孩
/* ********** Brandon Jaspers  **********
1. Brandon是一个身材高大的男孩,有一头短短的褐色头发。
2. 他性格外向好动,喜欢玩笑打趣其他人。
3. 在游戏中,Brandon是队伍中的辅助输出型角色。
4. 他有一个“偷袭”的特殊技能,可以对猎人进行额外攻击。
5. Brandon还会使用“ entertainment”技能来提升队友的士气。
6. 他的生命值一般,需要队友照应。
7. 如果Brandon牺牲,队伍输出伤害会下降。
8. Brandon经常开玩笑逗队友笑,营造乐观气氛。
9. 他的偷袭输出对削弱猎人也很关键。
10. Brandon给人一种活泼幽默的感觉,是个很有魅力的角色。
 *****************************************/

//11. Madame Zostra - 一个身材瘦小的老妪
/* ********** Madame Zostra  **********
1. Madame Zostra是一个身材瘦小的老妪,头戴一顶尖尖黑色尖帽。
2. 她性格神秘兮兮,据说拥有通灵的魔法能力。
3. 在游戏中,Zostra是队伍中的术士输出型角色。
4. 她有一个“咒语”的特殊技能,可以对猎人施加负面效果。
5. Zostra还会使用“预言”技能来预测隐患和机遇。
6. 她的生命值不高,需要队友保护。
7. 如果Zostra牺牲,队伍魔法伤害会减弱。
8. Zostra经常念念有词,做些怪异的手势动作。
9. 她的魔法对削弱和束缚猎人很关键。
10. Zostra给人一种神秘幽灵的感觉,是一个特别的游戏角色。
 *****************************************/

//12. Vivian Lopez - 一个身材高挑的拉丁美女
/* ********** Vivian Lopez  **********
1. Vivian是一个身材高挑的拉丁美女,有一头及腰的长发。
2. 她性格开朗大方,喜欢与人交流。
3. 在游戏中,Vivian是队伍中的辅助输出型角色。
4. 她有一个“鼓舞”的特殊技能,可以提升队友的士气。
5. Vivian还会使用“催眠”技能来暂时控制猎人。
6. 她的生命值一般,需要队友照应。
7. 如果Vivian牺牲,队伍输出伤害会下降。
8. Vivian经常用幽默来调节队伍气氛。
9. 她的鼓舞输出对削弱猎人也很关键。
10. Vivian给人一种活泼幽默的感觉,是个很有魅力的角色。
 *****************************************/

enum Character {
  littleGirlMissy,
  littleGirlZoe,
  oldmanProfessor,
  oldmanFather,
  motherHeather,
  motherJenny,
  brotherOx,
  brotherDarrin,
  littleBoyPeter,
  littleBoyBrandon,
  oldwomanMadame,
  oldwomanVivian,
}

/*
1. 继承自FlameGame,这是Flame引擎提供的游戏主类基类。
2. 混入(with)了一些Flame提供的辅助类,如键盘输入处理、碰撞检测等。
3. 定义了一些重要的游戏组件,如World(游戏世界)、游戏状态管理器、物体管理器等。
4. implements了一些FlameGame要实现的方法,如onLoad负责加载资源,update负责每帧更新逻辑。
5. 定义了一些游戏流程控制的方法,如初始化游戏,开始游戏,重置游戏等。
6. 处理游戏状态切换逻辑,如菜单切换,游戏开始/结束等。

这个类作为游戏的入口,管理游戏的主要逻辑流程,负责加载资源、组装场景,并控制游戏状态运行的整个生命周期
*/
class BlackHouseGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  BlackHouseGame({super.children});

  final World _world = World();
  // LevelManager levelManager = LevelManager();
  //GameManager gameManager = GameManager();
  // int screenBufferSpace = 300;
  // ObjectManager objectManager = ObjectManager();

  // late Player player;

  @override
  Future<void> onLoad() async {
    await add(_world);

    // await add(gameManager);

    overlays.add('gameOverOverlay');
    overlays.add('characterSelectOverlay');
    overlays.add('mainMenuOverlay');

    // await add(levelManager);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Losing the game: Add isGameOver check

    // if (gameManager.isIntro) {
    //   overlays.add('mainMenuOverlay');
    //   return;
    // }

    // if (gameManager.isPlaying) {
    //   checkLevelUp();

    // Core gameplay: Add camera code to follow Dash during game play

    // Losing the game: Add the first loss condition.
    // Game over if Dash falls off screen!
    // }
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 39, 40, 41);
  }

  void initializeGameStart() {
    setCharacter();

    // gameManager.reset();

    // if (children.contains(objectManager)) objectManager.removeFromParent();

    // levelManager.reset();

    // // Core gameplay: Reset player & camera boundaries

    // player.resetPosition();

    // objectManager = ObjectManager(
    //     minVerticalDistanceToNextPlatform: levelManager.minDistance,
    //     maxVerticalDistanceToNextPlatform: levelManager.maxDistance);

    // add(objectManager);

    // objectManager.configure(levelManager.level, levelManager.difficulty);
  }

  void setCharacter() {
    // player = Player(
    //   character: gameManager.character,
    //   jumpSpeed: levelManager.startingJumpSpeed,
    // );
    // add(player);
  }

  void startGame() {
    initializeGameStart();
    // gameManager.state = GameState.playing;
    // overlays.remove('mainMenuOverlay');
  }

  void resetGame() {
    startGame();
    //overlays.remove('gameOverOverlay');
  }

  // Losing the game: Add an onLose method

  void togglePauseState() {
    // if (paused) {
    //   resumeEngine();
    // } else {
    //   pauseEngine();
    // }
  }

  void checkLevelUp() {
    // if (levelManager.shouldLevelUp(gameManager.score.value)) {
    //   levelManager.increaseLevel();

    //   objectManager.configure(levelManager.level, levelManager.difficulty);

    //   // Core gameplay: Call setJumpSpeed
    // }
  }
}
