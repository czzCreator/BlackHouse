//物品卡牌
import 'dart:math';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flame/sprite.dart';
import 'package:blackhouse/component/base_component.dart';
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:blackhouse/cards/itemsCards/itemscard_model.dart';

//继承事件父类
class ItemsCard extends ItemModel with BaseComponent{

  ItemsCard(BlackHouseGame game,Sprite cardSprite,Offset position,int  cardid)
      : super(game,cardSprite,position,cardid){

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
    canvas.translate(ScreenUtil().setWidth(283*imagerate) / 2+position.dx, ScreenUtil().setWidth(540*imagerate) / 2+position.dy);
    // 2.3 画布旋转90°
    canvas.rotate( rotationAngle*pi / 180);
    // 2.4 绘制图像 图像起始点需偏移负宽高
    //ctx.drawImage(img, -this.width / 2, -this.height / 2);
    canvas.translate(-ScreenUtil().setWidth(283*imagerate) / 2, -ScreenUtil().setWidth(540*imagerate) / 2);

    //绘制地图
    cardSprite.renderRect(canvas,Rect.fromLTWH(0, 0, ScreenUtil().setWidth(283*imagerate), ScreenUtil().setWidth(540*imagerate)));
    canvas.restore();
  }

}
