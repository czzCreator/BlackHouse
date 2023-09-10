// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class FadeInButton extends StatefulWidget {
  final String text;

  const FadeInButton(
      {super.key, required this.text, required this.onHoverChanged});

  @override
  State<FadeInButton> createState() => _FadeInButtonState();

  bool get isHovered => _FadeInButtonState().isHovered;

  //这种回调比较特别：ValueChanged是Flutter定义的回调函数类型,用于传递一个新的值给回调接收者
  final ValueChanged<bool> onHoverChanged;
}

class _FadeInButtonState extends State<FadeInButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isHovered = false;
  bool get isHovered => _isHovered;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.dispose();
      }
    });

    _controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // 背景颜色
          borderRadius: BorderRadius.circular(10), // 圆角
          boxShadow: const [
            // 外阴影 多画几圈阴影 有立体效果,模糊化 向一方向拓展
            BoxShadow(
                color: Colors.white12, offset: Offset(1, 1), blurRadius: 2),
            BoxShadow(
                color: Colors.white24, offset: Offset(3, 3), blurRadius: 5),
            BoxShadow(
                color: Colors.white24, offset: Offset(5, 5), blurRadius: 8),
          ],
        ),
        child: MouseRegion(
            // 鼠标悬停事件
            onEnter: (event) {
              setState(() {
                _isHovered = true;
                //通知外面 值变化了
                widget.onHoverChanged(_isHovered);
              });
            },
            onExit: (event) {
              setState(() {
                _isHovered = false;
                //通知外面 值变化了
                widget.onHoverChanged(_isHovered);
              });
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // 悬停显示的图标
                //if (_isHovered)
                // 下面这是加载 按钮里面
                // const Padding(
                //   padding: EdgeInsets.only(left: 0.0),
                //   child: Icon(
                //     Icons.touch_app,
                //     color: Colors.white,
                //     size: 24,
                //   ),
                // ),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 3000),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withAlpha(50),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: (_isHovered ? 2.0 : 0.0),
                        color:
                            (_isHovered ? Colors.white70 : Colors.transparent),
                      ), // 边框颜色
                    ), // 点击事件
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                        color: Colors.white, // 文字白色
                        fontSize: 14.0, // 字体大小
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Pixel', // 像素风格字体
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
