import 'dart:math';



import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:blackhouse/game/blackhousegame.dart';

abstract class MapModel {
  int mapid;
  String roomname="";  //房间名
  String rules="";     //房间规则

  double maprate=1;    //地图缩放比，小地图为0.2

  final BlackHouseGame game;
  Sprite mapSprite;
  //摆放位置
  Offset position;

  MapModel(this.game,this.mapSprite,this.position,this.mapid);
  //当前地图块是否展现
  bool isshow=false;
  //地图块最后展现位置，未了切换用户场景时用到  0: 未放置  1：左边   2：中间   3：右边
  int lastlocation=0;
  //是否被翻开
  bool isopen=false;
  //当前地图块左门, 按原图顺时针的左，上，右，下，分别定义为门1，2，3，4, 不存在为0
  int leftdoor=1;
  int updoor=2;
  int rightdoor=3;
  int downdoor=4;

  Sprite leftPressSprite=new Sprite("maps/press.png");
  Sprite upPressSprite=new Sprite("maps/press.png");
  Sprite rightPressSprite=new Sprite("maps/press.png");
  Sprite downPressSprite=new Sprite("maps/press.png");

  //旋转角度  0 保持素材的角度，90：顺时针90度  180：顺时针180度   270： 顺时针270度
  //对应的门的编号也变化，例如90度时， leftdoor=4, updoor=1, rightdoor=2 ,downdoor=3
  int 	rotationAngle=0;
  //地图块中的玩家队列
  List<int> playerlist=[];
  //地图块左门旁边的门编号，没探索或者是没有左门置为0
  int theleftroom=0;
  //地图块上门旁边的门编号，没探索或者是没有上门置为0
  int theuproom=0;
  //地图块右门旁边的门编号，没探索或者是没有右门置为0
  int therightroom=0;
  //地图块下门旁边的门编号，没探索或者是没有下门置为0
  int thedownroom=0;
  //地图块中间通向的房间，适用于上下楼
  int themiddleroom=0;
  //地图块中的物品队列
  List<int> goodslist=[];
  //预兆标志个数，根据房间属性初始化，如果有翻开房间后归0
  int omenflags=0;
  //事件标志个数，根据房间属性初始化，如果有翻开房间后归0
  int eventflags=0;
  //物品标志个数，根据房间属性初始化，如果有翻开房间后归0
  int itemflags=0;
  //电梯标志,根据房间属性初始化，如果有翻开房间后有标志固定未1
  int liftflags=0;
  //任意抽卡标志,根据房间属性初始化，如果有翻开房间后归0
  int randomflags=0;
  //是否可放置地下室
  bool ifsetunderground=false;
  //是否可放置一楼
  bool ifsetground=false;
  //是否可放置二楼
  bool ifsetupground=false;
  //是否可放置顶楼
  bool ifsettopground=false;
  //当前被放置层数, 0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼
  int currentlayer=0;
  //小地图横坐标
  int x=100;
  //小地图纵坐标
  int y=100;

  //事件牌list
  List<int> eventslist=[];
  //物品牌list
  List<int> itemslist=[];
  //征兆牌list
  List<int> omenslist=[];
//判定要用的骰子数目
  int dicenum=0;
  //祝福标记
  int zhufuflag=0;
  Sprite zhufusprite=new Sprite("maps/zhufuflag.png");
  //壁橱标记
  int bichuflag=0;
  Sprite bichusprite=new Sprite("maps/bichuflag.png");
  //滴答标记
  int tickflag=0;
  Sprite ticksprite=new Sprite("maps/didaflag.png");
  //保险箱标记
  int strongboxflag=0;
  Sprite strongboxsprite=new Sprite("maps/baoxianflag.png");
  //滑梯上端标记
  int huatiupflag=0;
  Sprite huatiupsprite=new Sprite("maps/huatiflag.png");
  //滑梯上端标记
  int huatidownflag=0;
  Sprite huatidownsprite=new Sprite("maps/huatiflag.png");
  //骸骨标记
  int boneflag=0;
  Sprite bonesprite=new Sprite("maps/boneflag.png");
  //墙壁开关标记
  int openwallflag=0;
  Sprite openwallsprite=new Sprite("maps/boneflag.png");
  //秘密通道标记
  int secretwayflag=0;
  Sprite secretwaysprite=new Sprite("maps/boneflag.png");
  //秘密楼梯标记
  int secretstairsflag=0;
  Sprite secretstairssprite=new Sprite("maps/boneflag.png");
  //烟雾标记
  int smokeflag=0;
  Sprite smokesprite=new Sprite("maps/boneflag.png");
  //冢标记
  int tombsflag=0;
  Sprite tombssprite=new Sprite("maps/boneflag.png");
  //植物标记
  int plantflag=0;
  Sprite plantsprite=new Sprite("maps/boneflag.png");

}
