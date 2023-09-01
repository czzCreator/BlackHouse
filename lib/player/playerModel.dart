import 'package:flutter/material.dart';
abstract class PersonModel{
  //人物编号
  late int personid;
  //玩家编号
  late int playerid;
  //人物名称
  late String personname;
  //玩家名称
  late String playername;
  //人物初始速度等级
  late int initspeed;
  //人物初始力量等级
  late int initmight;
  //人物初始神志等级
  late int initsanity;
  //人物初始知识等级
  late int initknowledge;
  //人物当前速度等级
  late int currentspeed;
  //人物当前力量等级
  late int currentmight;
  //人物当前神志等级
  late int currentsanity;
  //人物当前知识等级
  late int currentknowledge;

  //人物速度表
  late List<int> speedlist;
  //人物力量表
  late List<int> mightlist;
  //人物神志表
  late List<int> sanitylist;
  //人物知识表
  late List<int> knowledgelist;

  //人物物品卡，以物品id关联
  List<int> itemslist=[];
  //人物事件卡，以物品id关联
  List<int> eventslist=[];
  //人物预兆卡，以物品id关联
  List<int> omenslist=[];
  //当前是否操作状态
  bool isplaying=false;
  //人物路线
  List<Offset> maproutelist=[];
  //当前所处房间
  int currentmapid=3;
  int rotationAngle=0;
  //剩余步数
  int step=5;
  //缩放比
  double scalerate=1;
  //瓦砾被压住回合数
  int walinum=0;


  //final BlackHouseGame game;
 // AnimationComponent personcomponent;
 // final personcomponentfront;
//  final personcomponentleft;
//  final personcomponentright;
//  final personcomponentback;

 // Sprite currentArrow;

  //摆放位置
  late Offset position;
  //人物方向
  String direct="front";   //front,left,right,back

 // PersonModel(this.game,this.personcomponent,this.personcomponentfront,this.personcomponentleft,
 //     this.personcomponentright,this.personcomponentback,this.currentArrow,this.position,this.playerid,this.playername);

}
