// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:window_manager/window_manager.dart';
//引入这个是为了 调用 桌面环境的 exit()方法 退出程序
import 'dart:io';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'fade_in_button.dart';

// Overlay that appears for the main menu
class MainMenuOverlay extends StatefulWidget {
  const MainMenuOverlay(this.game, {super.key});

  final Game game;

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _titleAnimationController;
  late Animation _titleAnimation;

  var localSkeletonHand = Image.asset(
    'assets/images/game_option_page/skeleton_hand.png',
    width: 64,
    height: 32,
    color: Colors.white,
  );

  bool _isSinglePlayerHovered = false;
  late final FadeInButton _singlePlayerButton = FadeInButton(
    text: 'Single Player',
    onHoverChanged: (bool isHovered) {
      setState(() {
        _isSinglePlayerHovered = isHovered;
      });
    },
    onPressed: () {
      // 按钮被点击时 跳转到角色 选择界面 选人物
      print("to select character ......");
    },
  );
  bool _isMultiPlayerHovered = false;
  late final FadeInButton _multiPlayerButton = FadeInButton(
    text: 'MultiPlayer',
    onHoverChanged: (bool isHovered) {
      setState(() {
        _isMultiPlayerHovered = isHovered;
      });
    },
    onPressed: () {
      // do something laterly .....
    },
  );
  bool _isSettingsHovered = false;
  late final FadeInButton _settingsButton = FadeInButton(
    text: 'Settings',
    onHoverChanged: (bool isHovered) {
      setState(() {
        _isSettingsHovered = isHovered;
      });
    },
    onPressed: () {
      // do something laterly ..... for settings
    },
  );
  bool _isQuitHovered = false;
  late final FadeInButton _quitButton = FadeInButton(
    text: 'Quit',
    onHoverChanged: (bool isHovered) {
      setState(() {
        _isQuitHovered = isHovered;
      });
    },
    onPressed: () async {
      bool isExit = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("退出游戏"),
              content: const Text("您确定要退出游戏吗?"),
              actions: [
                TextButton(
                  child: const Text("否"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text("是"),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          });

      if (isExit) {
        // 用户选择退出,执行退出逻辑
        if (Platform.isWindows) {
          // 当前在Windows上运行退出
          windowManager.close();
        } else if (Platform.isMacOS) {
          // 当前在MacOS上运行退出
        } else if (Platform.isLinux) {
          // 当前在Linux上运行退出
        } else if (Platform.isAndroid) {
          // 当前在Android上运行退出
        } else if (Platform.isIOS) {
          // 当前在IOS上运行退出
        } else if (Platform.isFuchsia) {
          // 当前在Fuchsia上运行退出
        }
      }
    },
  );

  @override
  void initState() {
    super.initState();

    _titleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _titleAnimation = Tween(begin: -500.0, end: -100.0).animate(CurvedAnimation(
        parent: _titleAnimationController, curve: Curves.easeOut));

    _titleAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _titleAnimationController.dispose();
      }
    });

    _titleAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景层
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/game_option_page/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // 动画标题层
          Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _titleAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: (1.2 - _titleAnimation.value / -500),
                  child: Transform.translate(
                    offset: Offset(0, _titleAnimation.value),
                    child: Image.asset(
                      'assets/images/game_option_page/game_title.png',
                      width: 300,
                      height: 85,
                    ),
                  ),
                );
              },
            ),
          ),

          // 按钮层
          Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isSinglePlayerHovered) localSkeletonHand,
                      _singlePlayerButton,
                    ],
                  ),
                  const WhiteSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isMultiPlayerHovered) localSkeletonHand,
                      _multiPlayerButton,
                    ],
                  ),
                  const WhiteSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isSettingsHovered) localSkeletonHand,
                      _settingsButton,
                    ],
                  ),
                  const WhiteSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isQuitHovered) localSkeletonHand,
                      _quitButton,
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({super.key, this.height = 10});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
