import 'dart:math';
import 'dart:ui' as UI;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flame/sprite.dart';
import 'package:blackhouse/component/base_component.dart';
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:blackhouse/persons/person_model.dart';
import 'package:flame/animation.dart' as flame_animation;
import 'package:flame/components/animation_component.dart';



//继承人物父类
class Person extends PersonModel {

  Person(BlackHouseGame game, AnimationComponent personcomponent,
      final personcomponentfront
      ,final personcomponentleft
  , final personcomponentright
  , final personcomponentback,
      Sprite currentArrow,
      Offset position,int playerid,String playername)
      : super(game, personcomponent,personcomponentfront,
         personcomponentleft,personcomponentright,
         personcomponentback,currentArrow ,position, playerid,playername){
  }

  @override
  void render(Canvas canvas) {
    drawArrow(canvas);
  }

  @override
  void update(double t) {
  }

  void drawArrow(Canvas canvas) {
    double perpix=5;
    canvas.save();
    if(this.game.currentplayer==playerid)
    currentArrow.renderRect(canvas,Rect.fromLTWH(15, -30, ScreenUtil().setWidth(20), ScreenUtil().setWidth(30)));
    //-----------------------------------------------------
    UI.ParagraphBuilder pA = UI.ParagraphBuilder(UI.ParagraphStyle(
      textAlign: TextAlign.left, // 对齐方式
      fontWeight: FontWeight.w700, // 粗体
      fontStyle: FontStyle.normal, // 正常 or 斜体
      fontSize: 11,
    ));

    pA.pushStyle(UI.TextStyle(color: Colors.red));
    pA.addText("$playername:$personname");

    // 绘制的宽度
    UI.ParagraphConstraints pB =
    UI.ParagraphConstraints(width: 120.0);
    UI.Paragraph paragraphname = pA.build()..layout(pB);
    canvas.drawParagraph(paragraphname, Offset(0, -10));

    //------------------------------------------------------
    Paint paint=new Paint();
    paint.color=Colors.red;  //设置画笔颜色
    paint.strokeWidth=5;//设置画笔宽度

    UI.ParagraphBuilder pb = UI.ParagraphBuilder(UI.ParagraphStyle(
      textAlign: TextAlign.left, // 对齐方式
      fontWeight: FontWeight.w700, // 粗体
      fontStyle: FontStyle.normal, // 正常 or 斜体
      fontSize: 10,
    ));

    pb.addText("力量:${mightlist[currentmight]}");

// 绘制的宽度
    UI.ParagraphConstraints pc =
    UI.ParagraphConstraints(width: 40.0);
    UI.Paragraph paragraph = pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, Offset(30, 0));

    double linelength=(perpix*mightlist[currentmight]) as double;
    canvas.drawLine(Offset(70, 5), Offset(70+linelength, 5), paint);

    //----------------------------------------------------------
    UI.ParagraphBuilder pd = UI.ParagraphBuilder(UI.ParagraphStyle(
      textAlign: TextAlign.left, // 对齐方式
      fontWeight: FontWeight.w700, // 粗体
      fontStyle: FontStyle.normal, // 正常 or 斜体
      fontSize: 10,
    ));

    pd.addText("知识:${knowledgelist[currentknowledge]}");

// 绘制的宽度
    UI.ParagraphConstraints pe =
    UI.ParagraphConstraints(width: 40.0);
    UI.Paragraph paragraph2 = pd.build()..layout(pe);
    canvas.drawParagraph(paragraph2, Offset(30, 15));

    linelength=(perpix*knowledgelist[currentknowledge]) as double;
    paint.color=Colors.amber;
    canvas.drawLine(Offset(70, 20), Offset(70+linelength, 20), paint);
    //--------------------------------------------------------
    UI.ParagraphBuilder pf = UI.ParagraphBuilder(UI.ParagraphStyle(
      textAlign: TextAlign.left, // 对齐方式
      fontWeight: FontWeight.w700, // 粗体
      fontStyle: FontStyle.normal, // 正常 or 斜体
      fontSize: 10,
    ));

    pf.addText("速度:${speedlist[currentspeed]}");

// 绘制的宽度
    UI.ParagraphConstraints pg =
    UI.ParagraphConstraints(width: 40.0);
    UI.Paragraph paragraph3 = pf.build()..layout(pg);
    canvas.drawParagraph(paragraph3, Offset(30, 30));

    linelength=(perpix*speedlist[currentspeed]) as double;
    paint.color=Colors.blue;
    canvas.drawLine(Offset(70, 35), Offset(70+linelength, 35), paint);

    //----------------------------------------------------------
    UI.ParagraphBuilder ph = UI.ParagraphBuilder(UI.ParagraphStyle(
      textAlign: TextAlign.left, // 对齐方式
      fontWeight: FontWeight.w700, // 粗体
      fontStyle: FontStyle.normal, // 正常 or 斜体
      fontSize: 10,
    ));

    ph.addText("神志:${sanitylist[currentsanity]}");

// 绘制的宽度
    UI.ParagraphConstraints pj =
    UI.ParagraphConstraints(width: 40.0);
    UI.Paragraph paragraph4 = ph.build()..layout(pj);
    canvas.drawParagraph(paragraph4, Offset(30, 45));

    linelength=(perpix*sanitylist[currentsanity]) as double;
    paint.color=Colors.green;
    canvas.drawLine(Offset(70, 50), Offset(70+linelength, 50), paint);
    //------------------------------------
    canvas.restore();
  }
}
















