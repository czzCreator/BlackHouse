import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:flame/animation.dart' as flame_animation;
import 'package:flame/components/animation_component.dart';
abstract class PersonModel{

  //人物编号
  int personid;
  //玩家编号
  int playerid;
  //人物名称
  String personname;
  //玩家名称
  String playername;
  //人物初始速度等级
  int initspeed;
  //人物初始力量等级
  int initmight;
  //人物初始神志等级
  int initsanity;
  //人物初始知识等级
  int initknowledge;
  //人物当前速度等级
  int currentspeed;
  //人物当前力量等级
  int currentmight;
  //人物当前神志等级
  int currentsanity;
  //人物当前知识等级
  int currentknowledge;


  //人物速度表
  List<int> speedlist;
  //人物力量表
  List<int> mightlist;
  //人物神志表
  List<int> sanitylist;
  //人物知识表
  List<int> knowledgelist;

  //人物物品卡，以物品id关联
  List<int> itemlist=[];
  //人物事件卡，以物品id关联
  List<int> eventslist=[];
  //人物预兆卡，以物品id关联
  List<int> omenlist=[];
  //当前是否操作状态
  bool isplaying=false;
  //人物路线
  List<int> maproutelist=[];
  //当前所处房间
  int currentmapid=3;
  int rotationAngle=0;
  //剩余步数
  int step=5;
  //缩放比
  double scalerate=1;
  //瓦砾被压住回合数
  int walinum=0;


  final BlackHouseGame game;
  AnimationComponent personcomponent;
  final personcomponentfront;
  final personcomponentleft;
  final personcomponentright;
  final personcomponentback;

  Sprite currentArrow;

  //摆放位置
  Offset position;
  //人物方向
  String direct="front";   //front,left,right,back

  PersonModel(this.game,this.personcomponent,this.personcomponentfront,this.personcomponentleft,
      this.personcomponentright,this.personcomponentback,this.currentArrow,this.position,this.playerid,this.playername);

}
