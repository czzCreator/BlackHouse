import 'dart:math';
import 'dart:ui' as UI;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'playerModel.dart';


//继承人物父类
class Player extends PersonModel {

  //人物编号
  void setPersonid(int _personid) {this.personid=_personid;}
  int getPersonid() {return this.personid;}
  //玩家编号
  void setPlayerid(int _playerid) {this.playerid=_playerid;}
  int getPlayerid() {return this.playerid;}
  //人物名称
  void setPersonname(String _personname) {this.personname=_personname;}
  String getPersonname() {return this.personname;}
  //玩家名称
  void setPlayername(String _playername) {this.playername=_playername;}
  String getPlayername() {return this.playername;}
  //人物初始速度等级
  void setInitspeed(int _initspeed) {this.initspeed=_initspeed;}
  int getInitspeed() {return this.initspeed;}
  //人物初始力量等级
  void setInitmight(int _initmight) {this.initmight=_initmight;}
  int getInitmight() {return this.initmight;}
  //人物初始神志等级
  void setInitsanity(int _initsanity){this.initsanity=_initsanity;}
  int getInitsanity() {return this.initsanity;}
  //人物初始知识等级
  void setInitknowledge(int _initknowledge) {this.initknowledge=_initknowledge;}
  int getInitknowledge(){return this.initknowledge;}
  //人物当前速度等级
  void setCurrentspeed(int _currentspeed) {this.currentspeed=_currentspeed;}
  int getCurrentspeed() {return this.currentspeed;}
  //人物当前力量等级
  void setCurrentmight(int _currentmight) {this.currentmight=_currentmight;}
  int getCurrentmight() {return this.currentmight;}
  //人物当前神志等级
  void setCurrentsanity(int _currentsanity) {this.currentsanity=_currentsanity;}
  int getCurrentsanity() {return this.currentsanity;}
  //人物当前知识等级
  void setCurrentknowledge(int _currentknowledge){this.currentknowledge=_currentknowledge;}
  int getCurrentknowledge() {return this.currentknowledge;}
  //人物速度表
  void setSpeedlist(List<int> _speedlist){this.speedlist=_speedlist;}
  List<int> getSpeedlist() {return this.speedlist;}
  //人物力量表
  void setMightlist(List<int> _mightlist){this.mightlist=_mightlist;}
  List<int> getMightlist() {return this.mightlist;}
  //人物神志表
  void setSanitylist(List<int> _sanitylist){this.sanitylist=_sanitylist;}
  List<int> getSanitylist() {return this.sanitylist;}
  //人物知识表
  void setKnowledgelist(List<int> _knowledgelist){this.knowledgelist=_knowledgelist;}
  List<int> getKnowledgelist() {return this.knowledgelist;}
  //人物物品卡，以物品id关联
  List<int> itemslist=[];
  void insetItemslist(int _item){this.itemslist.add(_item);}
  void deletItemsInList(int _item){this.itemslist.remove(_item);}
  void deletItemsListAll(){this.itemslist.clear();}
  List<int> getItemslist(){return this.itemslist;}
  //人物事件卡，以物品id关联
  void insetEventslist(int _event){this.eventslist.add(_event);}
  void deletEventsInList(int _event){this.eventslist.remove(_event);}
  void deletEventsListAll(){this.eventslist.clear();}
  List<int> getEventslist(){return this.eventslist;}
  //人物预兆卡，以物品id关联
  void insetOmenslist(int _omen){this.omenslist.add(_omen);}
  void deletOmensInList(int _omen){this.omenslist.remove(_omen);}
  void deletOmensListAll(){this.omenslist.clear();}
  List<int> getOmenslist(){return this.omenslist;}
  //当前是否操作状态
  void setIsplaying(bool _isplaying) {this.isplaying=_isplaying;}
  bool getIsplaying() {return this.isplaying;}
  //人物路线
  void insetMaproutelist(Offset _maproute){this.maproutelist.add(_maproute);}
  List<Offset> getMaproutelist() {return this.maproutelist;}
  //当前所处房间
  void setCurrentmapid(int _currentmapid) {this.currentmapid=_currentmapid;}
  int getCurrentmapid() {return this.currentmapid;}

  void setRotationAngle(int _rotationangle){this.rotationAngle=_rotationangle;}
  int getRotationangle(){return this.rotationAngle;}
  //剩余步数
  void setSteps(int _step) {this.step=_step;}
  int getSteps() {return this.step;}
  //缩放比
  void setScalerate(double _scalerate) {this.scalerate=_scalerate;}
  double getScalerate() {return this.scalerate;}
  //瓦砾被压住回合数
  void setWalinum(int _walinum){this.walinum=_walinum;}
  int getWalinum() {return this.walinum;}

  //final BlackHouseGame game;
  // AnimationComponent personcomponent;
  // final personcomponentfront;
//  final personcomponentleft;
//  final personcomponentright;
//  final personcomponentback;

  // Sprite currentArrow;

  //摆放位置
  void setPositon(Offset _position) {this.position=_position;}
  Offset getPositon() {return this.position;}
  //人物方向
  void setDirect(String _direct) {this.direct=_direct;}
  String getDirect() {return this.direct;}

}
















