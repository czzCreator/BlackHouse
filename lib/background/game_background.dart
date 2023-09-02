import 'package:flame/components.dart';

class GameBackground extends SpriteComponent {
  //Sprite bgSprite;

  GameBackground() {
    //bgSprite = Sprite('background.png');

    addDecorations();
  }

  // 加载背景图,返回Sprite
  //Sprite loadBackgroundImage() {

  //}

  @override
  Future<void> onLoad() async {
    // 加载资源
  }

  void addDecorations() {
    anchor = Anchor.center;

    // 圆角
    //shape = RoundedRectangleShape(borderRadius: BorderRadius.circular(20));

    // 边框
    //add(
    // RectangleBorderComponent(
    //   priority: 2,
    //   rectangle: shape,
    //   paint: BasicPalette.white.withStrokeWidth(4),
    // ),
    //);

    // 阴影
    //add(
    // ShadowComponent(
    //   priority: 1,
    //   shadow: Shadow(
    //     color: BasicPalette.black.withAlpha(100),
    //     offset: Offset(2, 2),
    //     blurRadius: 4,
    //   )
    // )
    //);

    // 顶部渐变装饰条
    add(GradientDecoration(
        // priority: 3,
        // y: 10,
        // width: size.x
        ));

    // 底部渐变装饰条
    add(GradientDecoration(
        // priority: 3,
        // y: size.y - 30,
        // width: size.x
        ));
  }
}

class GradientDecoration extends PositionComponent {
  // 渐变实现
}
