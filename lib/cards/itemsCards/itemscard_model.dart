//物品卡牌父类
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:blackhouse/game/blackhousegame.dart';

abstract class ItemModel{
  int cardid;
  String cardname="";  //卡牌名
  String cardstory="";  //卡牌剧情
  String cardcontent="";     //卡牌规则
  double imagerate=1;    //地图缩放比，小地图为0.2
  final BlackHouseGame game;
  Sprite cardSprite;
  //物品标志个数.//扫帚柄
  int itemflags=0;
  //知识标志个数.//手持摄像机
  int knowledgeflags=0;
  //知识标记玩家队列 //手持摄像机
  List<int> knowledgeflagplayers=[];
  //是否是武器
  bool iswepon=false;

  //摆放位置
  Offset position;
  ItemModel(this.game,this.cardSprite,this.position,this.cardid);
  //当前卡牌是否被抽取
  bool isopen=false;
  //是否可以被偷窃
  bool isstolen=true;
  //抽取此卡的地图id
  int choosemapid=0;
  //旋转角度  0 保持素材的角度，90：顺时针90度  180：顺时针180度   270： 顺时针270度
  int 	rotationAngle=0;
  //抽取或拥有此卡的玩家,如果是放在房间里，则ownerid=0；
  int ownerid=0;

}