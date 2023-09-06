// Copyright 2022 The Czz/WanChao Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import './world.dart';

enum Character { dash, sparky }

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
  // GameManager gameManager = GameManager();
  // int screenBufferSpace = 300;
  // ObjectManager objectManager = ObjectManager();

  // late Player player;

  @override
  Future<void> onLoad() async {
    await add(_world);

    // await add(gameManager);

    overlays.add('gameOverOverlay');

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
    return Color.fromARGB(255, 39, 40, 41);
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
