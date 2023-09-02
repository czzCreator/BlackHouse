//预兆卡牌父类
import 'dart:math';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:blackhouse/game/blackhousegame.dart';

abstract class OmenModel{
  int cardid;
  String cardname="";  //卡牌名
  String cardcontent="";     //卡牌规则
  String cardstory="";  //卡牌剧情
  double imagerate=1;    //地图缩放比，小地图为0.2
  final BlackHouseGame game;
  Sprite cardSprite;
  //摆放位置
  Offset position;
  OmenModel(this.game,this.cardSprite,this.position,this.cardid);
  //当前卡牌是否被抽取
  bool isopen=false;
  //抽取此卡的地图id
  int choosemapid=0;
  //旋转角度  0 保持素材的角度，90：顺时针90度  180：顺时针180度   270： 顺时针270度
  int 	rotationAngle=0;
  //抽取或拥有此卡的玩家
  int ownerid=0;
}