import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flame/animation.dart' as flame_animation;
import 'package:flame/components/animation_component.dart';

//骰子类
class Dices  {

  Dices(BlackHouseGame game, this.actionDiceComponent,
      this.diceSprite0,this.diceSprite1,this.diceSprite2,
      this.position,this.dice_id) {
  }

  AnimationComponent actionDiceComponent;
  Sprite diceSprite0;
  Sprite diceSprite1;
  Sprite diceSprite2;
  bool actionshow;
  bool diceshow;
  int diceNum;
  Offset position;
  int dice_id;

  double maprate=1;    //缩放比
  int 	rotationAngle=0;

  @override
  void render(Canvas canvas) {
    drawMap(canvas);
  }

  @override
  void update(double t) {
  }

  void drawMap(Canvas canvas) {
    //地图块都弄成ScreenUtil().setWidth(400)*ScreenUtil().setWidth(400)
    //将canvas 原点设置在tank上
    canvas.save();
    // 2.2 画布中心点(也是起始点)平移至中心(0,0)->(x,y)
    canvas.translate(ScreenUtil().setWidth(80*maprate) / 2+position.dx, ScreenUtil().setWidth(80*maprate) / 2+position.dy);
    // 2.3 画布旋转90°
    canvas.rotate( rotationAngle*pi / 180);
    // 2.4 绘制图像 图像起始点需偏移负宽高
    //ctx.drawImage(img, -this.width / 2, -this.height / 2);
    canvas.translate(-ScreenUtil().setWidth(80*maprate) / 2, -ScreenUtil().setWidth(80*maprate) / 2);

    //绘制地图
    if(diceNum==0)
    diceSprite0.renderRect(canvas,Rect.fromLTWH(0, 0, ScreenUtil().setWidth(80), ScreenUtil().setWidth(80)));
    else if(diceNum==1)
      diceSprite1.renderRect(canvas,Rect.fromLTWH(0, 0, ScreenUtil().setWidth(80), ScreenUtil().setWidth(80)));
    else if(diceNum==2)
      diceSprite2.renderRect(canvas,Rect.fromLTWH(0, 0, ScreenUtil().setWidth(80), ScreenUtil().setWidth(80)));

    canvas.restore();
  }

}
















