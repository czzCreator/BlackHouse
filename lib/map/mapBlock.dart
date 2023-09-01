import 'dart:ui';

import 'mapModel.dart';

//继承地图父类
class Mapblock extends MapModel  {
  //房间id
  void setMapid(int _mapid) {this.mapid=_mapid;}
  int getMapid() {return this.mapid;}
  //房间名
  void setRoomname(String _roomname) {this.roomname=_roomname;}
  String getRoomname() {return this.roomname;}
   //房间规则
  void setRules(String _rules) {this.rules=_rules;}
  String getRules() {return this.rules;}
   //房间图片路径
  void setMapSprite(String _mapSprite) {this.mapSprite=_mapSprite;}
  String getMapSprite() {return this.mapSprite;}
  //摆放位置
  void setPosition(Offset _position) {this.position=_position;}
  Offset getPosition() {return this.position;}
  //当前地图块是否展现
  void setIsshow(bool _isshow) {this.isshow=_isshow;}
  bool getIsshow() {return this.isshow;}
  //地图块最后展现位置，未了切换用户场景时用到  0: 未放置  1：左边   2：中间   3：右边
  void setLastlocation(int _lastlocation) {this.lastlocation=_lastlocation;}
  int getLastlocation() {return this.lastlocation; }
  //是否被翻开
  void setIsopen(bool _isopen) {this.isopen=_isopen;}
  bool getIsopen() {return this.isopen;}
  //当前地图块左门, 按原图顺时针的左，上，右，下，分别定义为门'L'，'U'，'R'，'D', 不存在为0
  void setDoor(String _direction,String realDirection) {
    if(realDirection=="left") this.leftdoor=_direction;
    else if(realDirection=="up") this.updoor=_direction;
    else if(realDirection=="right") this.rightdoor=_direction;
    else if(realDirection=="down") this.downdoor=_direction;}
  String getDoor(String realDirection)  {
    if(realDirection=="left") return this.leftdoor;
    else if(realDirection=="up") return this.updoor;
    else if(realDirection=="right") return this.rightdoor;
    else if(realDirection=="down") return this.downdoor;
    else return "O";}
  //旋转角度  0 保持素材的角度，90：顺时针90度  180：顺时针180度   270： 顺时针270度
  //对应的门的编号也变化，例如90度时， leftdoor=4, updoor=1, rightdoor=2 ,downdoor=3
  void setRotationangle(int _rotationAngle){this.rotationAngle=_rotationAngle;}
  int getRotationangle(){return this.rotationAngle;}
  //地图块中的玩家队列
  void insetPlayerlist(int _player){this.playerlist.add(_player);}
  void deletPlayerInList(int _player){this.playerlist.remove(_player);}
  void deletPlayerListAll(){this.playerlist.clear();}
  List<int> getPlayerlist(){return this.playerlist;}
  //事件牌list
  void insetEventslist(int _event){this.eventslist.add(_event);}
  void deletEventsInList(int _event){this.eventslist.remove(_event);}
  void deletEventsListAll(){this.eventslist.clear();}
  List<int> getEventslist(){return this.eventslist;}
  //物品牌list
  void insetItemslist(int _item){this.itemslist.add(_item);}
  void deletItemsInList(int _item){this.itemslist.remove(_item);}
  void deletItemsListAll(){this.itemslist.clear();}
  List<int> getItemslist(){return this.itemslist;}
  //征兆牌list
  void insetOmenslist(int _omen){this.omenslist.add(_omen);}
  void deletOmensInList(int _omen){this.omenslist.remove(_omen);}
  void deletOmensListAll(){this.omenslist.clear();}
  List<int> getOmenslist(){return this.omenslist;}
  //地图块中间通向的房间，适用于上下楼
  void setMiddleuproom(Offset _offset) {this.themiddleuproom=_offset;}
  Offset getMiddleuproom() {return this.themiddleuproom;}
  void setMiddledownroom(Offset _offset) {this.themiddledownroom=_offset;}
  Offset getMiddledownroom() {return this.themiddledownroom;}
  //预兆标志个数，根据房间属性初始化，如果有翻开房间后归0
  void setomenflags(int num){this.omenflags=num;}
  int getomenflags(){return this.omenflags;}
  //事件标志个数，根据房间属性初始化，如果有翻开房间后归0
  void seteventflags(int num){this.eventflags=num;}
  int geteventflags(){return this.eventflags;}
  //物品标志个数，根据房间属性初始化，如果有翻开房间后归0
  void setitemflags(int num){this.itemflags=num;}
  int getitemflags(){return this.itemflags;}
  //电梯标志,根据房间属性初始化，如果有翻开房间后有标志固定未1
  void setliftflags(int num){this.liftflags=num;}
  int getliftflags() {return this.liftflags;}
  //任意抽卡标志,根据房间属性初始化，如果有翻开房间后归0
  void setrandomflags(int num){this.randomflags=num;}
  int getrandomflags(){return this.randomflags;}
  //是否可放置地下室
  void setIfsetunderground(bool _is){this.ifsetunderground=_is;}
  bool getIfsetunderground(){return this.ifsetunderground;}
  //是否可放置一楼
  void setIfground(bool _is){this.ifsetground=_is;}
  bool getIfground(){return this.ifsetground;}
  //是否可放置二楼
  void setIfsetupground(bool _is){this.ifsetupground=_is;}
  bool getIfsetupground(){return this.ifsetupground;}
  //是否可放置顶楼
  void setIfsettopground(bool _is){this.ifsettopground=_is;}
  bool getIfsettopground(){return this.ifsettopground;}
  //当前被放置层数, 0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼
  void setCurrentlayer(int _layer){this.currentlayer=_layer;}
  int getCurrentlayer(){return this.currentlayer;}
  //地图横纵坐标,结合layer
  void setcoordinate(Offset _offset) {this.coordinate=_offset;}
  Offset getcoordinate() {return this.coordinate;}
  //地图缩放比，小地图为0.2
  void setMaprate(double _maprate){this.maprate=_maprate;}
  double getMaprate() {return this.maprate;}
  //判定要用的骰子数目
  void setDicenum(int _dicenum){this.dicenum=_dicenum;}
  int getDicenum(){return this.dicenum;}
  //祝福标记
  void setZhufuflag(int _zhufuflag){this.zhufuflag=_zhufuflag;}
  int getZhufuflag(){return this.zhufuflag;}
  //壁橱标记
  void setbichuflag(int _bichuflag){this.zhufuflag=_bichuflag;}
  int getbichuflag(){return this.bichuflag;}
  //滴答标记
  void setTickflag(int _tickflag){this.tickflag=_tickflag;}
  int getTickflag(){return this.tickflag;}
  //保险箱标记
  void setStrongboxflag(int _strongboxflag){this.strongboxflag=_strongboxflag;}
  int getStrongboxflag(){return this.strongboxflag;}
  //滑梯上端标记
  void setHuatiupflag(int _huatiupflag){this.huatiupflag=_huatiupflag;}
  int getHuatiupflag(){return this.huatiupflag;}
  //滑梯上端标记
  void setHuatidownflag(int _huatidownflag){this.huatidownflag=_huatidownflag;}
  int getHuatidownflag(){return this.huatidownflag;}
  //骸骨标记
  void setBoneflag(int _boneflag){this.boneflag=_boneflag;}
  int getBoneflag(){return this.boneflag;}
  //墙壁开关标记
  void setOpenwallflag(int _openwallflag){this.openwallflag=_openwallflag;}
  int getOpenwallflag(){return this.openwallflag;}
  //秘密通道标记
  void setSecretwayflag(int _secretwayflag){this.secretwayflag=_secretwayflag;}
  int getSecretwayflag(){return this.secretwayflag;}
  //秘密楼梯标记
  void setSecretstairsflag(int _secretstairsflag){this.secretstairsflag=_secretstairsflag;}
  int getSecretstairsflag(){return this.secretstairsflag;}
  //烟雾标记
  void setSmokeflag(int _smokeflag){this.smokeflag=_smokeflag;}
  int getSmokeflag(){return this.smokeflag;}
  //冢标记
  void setTombsflag(int _tombsflag){this.tombsflag=_tombsflag;}
  int getTombsflag(){return this.tombsflag;}
  //植物标记
  void setPlantflag(int _plantflag){this.plantflag=_plantflag;}
  int getPlantflag(){return this.plantflag;}

  //初始化房间
  void initMapRoom(
      String roomname,
      String rules,
      String leftdoor,String updoor,String rightdoor,String downdoor,
      int itemflags,int eventflags, int omenflags,int liftflags,int randomflags,
      bool ifsetunderground,bool ifsetground,bool ifsetupground,bool ifsettopground ,int currentlayer,
      Offset coordinate,Offset middledowncoordinate,Offset middleupcoordinate)
  {
    //初始化房间名和规则
    setRoomname(roomname);
    setRules(rules);
    //初始化门
    setDoor(leftdoor, 'L');
    setDoor(updoor,'U');
    setDoor(rightdoor, 'R');
    setDoor(downdoor, 'D');
    //初始化物品、事件、预兆
    setitemflags(itemflags);
    seteventflags(eventflags);
    setomenflags(omenflags);
    setliftflags(liftflags);
    setrandomflags(randomflags);
    //初始化可放置的楼层
    setIfsetunderground(ifsetunderground);
    setIfground(ifsetground);
    setIfsettopground(ifsettopground);
    setIfsetupground(ifsetupground);
    setCurrentlayer(currentlayer);
    setcoordinate(coordinate);
    setMiddledownroom(middledowncoordinate);
    setMiddleuproom(middleupcoordinate);
  }
}

