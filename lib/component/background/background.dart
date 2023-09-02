import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:blackhouse/component/base_component.dart';
import 'package:blackhouse/game/blackhousegame.dart';
import 'dart:ui' as UI;

class GameBackground with BaseComponent{

  final BlackHouseGame game;

  Sprite bgSprite;
  Rect bgRect;

  GameBackground(this.game){
    bgSprite = Sprite('gamebg.webp');
    bgRect = Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
  }

  @override
  void render(Canvas canvas) {
    bgSprite.renderRect(canvas, bgRect);

    if(game.showtips) {
      //绘制提示文字
      UI.ParagraphBuilder ph = UI.ParagraphBuilder(UI.ParagraphStyle(
        textAlign: TextAlign.left, // 对齐方式
        fontWeight: FontWeight.w700, // 粗体
        fontStyle: FontStyle.normal, // 正常 or 斜体
        fontSize: 15,
      ));

      ph.addText("${game.tips}");

// 绘制的宽度
      UI.ParagraphConstraints pj =
      UI.ParagraphConstraints(width:300.0);
      UI.Paragraph paragraph4 = ph.build()
        ..layout(pj);
      canvas.drawParagraph(paragraph4, Offset(600, 800));
    }
  }

  @override
  void update(double t) {

  }

}