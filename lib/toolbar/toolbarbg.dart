//工具栏框
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:blackhouse/component/base_component.dart';
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToolBarBackground with BaseComponent{

  final BlackHouseGame game;

  Sprite toolbarbgSprite;
  Rect bgRect;

  ToolBarBackground(this.game,{this.position}){
    toolbarbgSprite = Sprite('toolrect.png');
  }
  // 放置位置
  Offset position;

  @override
  void render(Canvas canvas) {
    drawToolBarBg(canvas);
  }


  @override
  void update(double t) {


  }

  void drawToolBarBg(Canvas canvas) {
    //将canvas 原点设置
    canvas.save();
    canvas.translate(position.dx, position.dy);

    //绘制背景框
    toolbarbgSprite.renderRect(canvas,Rect.fromLTWH(0, 0, ScreenUtil().setWidth(1200), ScreenUtil().setHeight(125)));

    canvas.restore();

  }

}