// Copyright 2022 The Flutter Authors: czz/wanchao. All rights reserved.

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import './black_house_game.dart';

/*
* 该类扩展 ParallaxComponent 以渲染游戏背景。该类接受图片资源列表，并按层对这些图片资源进行渲染，
* 确保每个层以不同的速度移动，以增强真实感。BlackHouseGame 类包含一个 ParallaxComponent 实例，
* 并通过 BlackHouseGame onLoad 方法将其添加到游戏中*/

/*
ParallaxComponent用于实现背景图像的视差滚动效果。它会将一系列图片作为层叠背景,并以不同的速度滚动,创建深度感。
baseVelocity参数就是用来设置背景中每一层图片的基础滚动速度的。它是一个二维向量,表示每一层图片在x轴和y轴上的滚动速度。
这里设置为:
baseVelocity: Vector2(0, -5)
表示每一层的基础Y轴速度为-5(向上滚动)。X轴速度为0。
之后通过velocityMultiplierDelta再分层设置Y轴速度的乘数,来控制每一层的相对滚动快慢。
这样就可以创建视差滚动的背景效果了,近层滚动快,远层滚动慢,形成视差效果。
baseVelocity决定了整个背景的基础滚动方向和速度。将它设定为向上滚动,然后通过调整其他参数生成视差滚动效果。
*/
class World extends ParallaxComponent<BlackHouseGame> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('game_option_page/bg.jpg'),
      ],
      fill: LayerFill.width,
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(0, -5),
      velocityMultiplierDelta: Vector2(0, 1.2),
    );
  }
}
