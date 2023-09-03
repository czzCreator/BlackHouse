// Copyright 2022 The Flutter Authors: czz/wanchao. All rights reserved.

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import './black_house_game.dart';

/*
* 该类扩展 ParallaxComponent 以渲染游戏背景。该类接受图片资源列表，并按层对这些图片资源进行渲染，
* 确保每个层以不同的速度移动，以增强真实感。BlackHouseGame 类包含一个 ParallaxComponent 实例，
* 并通过 BlackHouseGame onLoad 方法将其添加到游戏中*/
class World extends ParallaxComponent<BlackHouseGame> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('game/background/06_Background_Solid.png'),
        ParallaxImageData('game/background/05_Background_Small_Stars.png'),
        ParallaxImageData('game/background/04_Background_Big_Stars.png'),
        ParallaxImageData('game/background/02_Background_Orbs.png'),
        ParallaxImageData('game/background/03_Background_Block_Shapes.png'),
        ParallaxImageData('game/background/01_Background_Squiggles.png'),
      ],
      fill: LayerFill.width,
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(0, -5),
      velocityMultiplierDelta: Vector2(0, 1.2),
    );
  }
}
