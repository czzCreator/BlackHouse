import 'dart:math';
import 'dart:ui' as UI;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flame/sprite.dart';
import 'package:blackhouse/component/base_component.dart';
import 'package:flame/gestures.dart';
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:blackhouse/maps/map_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blackhouse/config/param.dart';



//继承地图父类
class Mapblock extends MapModel with BaseComponent  {

  Mapblock(BlackHouseGame game, Sprite mapSprite,Offset position,int mapid)
      : super(game, mapSprite, position, mapid){
  }

  @override
  void onTap(TapDownDetails details){
      print("点击了地图${game.maps[mapid].roomname}");
  }

  @override
  void render(Canvas canvas) {
    drawMap(canvas);
  }

  @override
  void update(double t) {
    //时间增量t 旋转速率

  }

  void drawMap(Canvas canvas) {
    //地图块都弄成ScreenUtil().setWidth(400)*ScreenUtil().setWidth(400)
    //将canvas 原点设置在tank上
    canvas.save();
    // 2.2 画布中心点(也是起始点)平移至中心(0,0)->(x,y)
    canvas.translate(ScreenUtil().setWidth(400*maprate) / 2+position.dx, ScreenUtil().setWidth(400*maprate) / 2+position.dy);
    // 2.3 画布旋转90°
    canvas.rotate( rotationAngle*pi / 180);
    // 2.4 绘制图像 图像起始点需偏移负宽高
    //ctx.drawImage(img, -this.width / 2, -this.height / 2);
    canvas.translate(-ScreenUtil().setWidth(400*maprate) / 2, -ScreenUtil().setWidth(400*maprate) / 2);

    //绘制地图
    mapSprite.renderRect(canvas,Rect.fromLTWH(0, 0, ScreenUtil().setWidth(400*maprate), ScreenUtil().setWidth(400*maprate)));

    //小地图绘制点击的手势
    drawPress(canvas);
    //绘制地图上的标志
    drawFlags(canvas);
    canvas.restore();
  }

  void setText(Canvas canvas,String text,Offset offset)
  {
    UI.ParagraphBuilder pA = UI.ParagraphBuilder(UI.ParagraphStyle(
      textAlign: TextAlign.left, // 对齐方式
      fontWeight: FontWeight.w900, // 粗体
      fontStyle: FontStyle.normal, // 正常 or 斜体
      fontSize: 9,
    ));

    pA.pushStyle(UI.TextStyle(color: Colors.red));
    pA.addText(text);

    // 绘制的宽度
    UI.ParagraphConstraints pB =
    UI.ParagraphConstraints(width: 80.0);
    UI.Paragraph paragraphname = pA.build()..layout(pB);
    canvas.drawParagraph(paragraphname, offset);
  }

  void drawFlags(Canvas canvas)
  {
    //祝福标记
    if(zhufuflag==1&&mapid<100){
      zhufusprite.renderRect(canvas,Rect.fromLTWH(30*maprate, 30*maprate, ScreenUtil().setWidth(40*maprate), ScreenUtil().setWidth(40*maprate)));
      setText(canvas,"祝福标记",Offset(30*maprate, 20*maprate));
    }

    //滴答标记
    if(tickflag==1&&mapid<100){
      ticksprite.renderRect(canvas,Rect.fromLTWH(210*maprate, 30*maprate, ScreenUtil().setWidth(40*maprate), ScreenUtil().setWidth(40*maprate)));
      setText(canvas,"滴答标记",Offset(210*maprate, 20*maprate));
    }

    //壁橱标记
    if(bichuflag==1&&mapid<100){
      bichusprite.renderRect(canvas,Rect.fromLTWH(70*maprate, 30*maprate, ScreenUtil().setWidth(40*maprate), ScreenUtil().setWidth(40*maprate)));
      setText(canvas,"壁橱标记",Offset(70*maprate, 20*maprate));
    }

    //保险箱标记
    if(strongboxflag==1&&mapid<100){
      strongboxsprite.renderRect(canvas,Rect.fromLTWH(170*maprate, 30*maprate, ScreenUtil().setWidth(40*maprate), ScreenUtil().setWidth(40*maprate)));
      setText(canvas,"保险箱标记",Offset(160*maprate, 20*maprate));
    }

    //滑梯上端标记
    if(huatiupflag==1&&mapid<100){
      huatiupsprite.renderRect(canvas,Rect.fromLTWH(170*maprate, 30*maprate, ScreenUtil().setWidth(40*maprate), ScreenUtil().setWidth(40*maprate)));
      setText(canvas,"滑梯上端标记",Offset(160*maprate, 20*maprate));
    }

    //滑梯下端标记
    if(huatidownflag==1&&mapid<100){
      huatidownsprite.renderRect(canvas,Rect.fromLTWH(170*maprate, 30*maprate, ScreenUtil().setWidth(40*maprate), ScreenUtil().setWidth(40*maprate)));
      setText(canvas,"滑梯下端标记",Offset(160*maprate, 20*maprate));
    }

    //骸骨下端标记
    if(boneflag==1&&mapid<100){
      bonesprite.renderRect(canvas,Rect.fromLTWH(170*maprate, 30*maprate, ScreenUtil().setWidth(40*maprate), ScreenUtil().setWidth(40*maprate)));
      setText(canvas,"骸骨标记",Offset(160*maprate, 20*maprate));
    }
  }

  //绘制小地图上未连接门上的点击图片
  void drawPress(Canvas canvas)
  {
    if(game.isshowlittemap&&ischooseRoomDoor)
    {
      double ratation=(rotationAngle/90)%4;
      int ra=ratation.toInt().abs();
      if(theleftroom==0&&leftdoor!=0)
      {
        switch(ra){
          case 0:
            leftPressSprite.renderRect(canvas,Rect.fromLTWH(0, ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 1:
            leftPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)*3/4, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 2:
            leftPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/4, ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 3:
            leftPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/8, 0, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
        }
      }
      if(theuproom==0&&updoor!=0)
      {
        switch(ra){
          case 0:
            upPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/8, 0, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 1:
            upPressSprite.renderRect(canvas,Rect.fromLTWH(0, ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 2:
            upPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)*3/4, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 3:
            upPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/4, ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
        }
      }
      if(therightroom==0&&rightdoor!=0)
      {
        switch(ra){
          case 0:
            rightPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/4, ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 1:
            rightPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/8, 0, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 2:
            rightPressSprite.renderRect(canvas,Rect.fromLTWH(0, ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 3:
            rightPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)*3/4, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
        }
      }
      if(thedownroom==0&&downdoor!=0)
      {
        switch(ra){
          case 0:
            downPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)*3/4, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 1:
            downPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/4, ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 2:
            downPressSprite.renderRect(canvas,Rect.fromLTWH(ScreenUtil().setWidth(400*maprate)*3/8, 0, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
          case 3:
            downPressSprite.renderRect(canvas,Rect.fromLTWH(0, ScreenUtil().setWidth(400*maprate)*3/8, ScreenUtil().setWidth(400*maprate)/4, ScreenUtil().setWidth(400*maprate)/4));
            break;
        }
      }
    }
  }

}
















