//物品牌操作
import 'package:blackhouse/game/blackhousegame.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:blackhouse/tools/cardstools.dart';

//1噬咬
Future omen01(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“噬咬”");
  await showOmenCard(1,blackhouseGame);
}
//2书
Future omen02(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“书”");
  await showOmenCard(2,blackhouseGame);
}
//3水晶球
Future omen03(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“水晶球”");
  await showOmenCard(3,blackhouseGame);
}
//4狗
Future omen04(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“狗”");
  await showOmenCard(4,blackhouseGame);
}
//5女孩
Future omen05(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“女孩”");
  await showOmenCard(5,blackhouseGame);
}
//6圣符
Future omen06(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“圣符”");
  await showOmenCard(6,blackhouseGame);
}
//7疯汉
Future omen07(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“疯汉”");
  await showOmenCard(7,blackhouseGame);
}
//8面具
Future omen08(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“面具”");
  await showOmenCard(8,blackhouseGame);
}
//9徽章
Future omen09(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“徽章”");
  await showOmenCard(9,blackhouseGame);
}
//10戒指
Future omen10(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“戒指”");
  await showOmenCard(10,blackhouseGame);
}
//11骷髅头
Future omen11(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“骷髅头”");
  await showOmenCard(11,blackhouseGame);
}
//12长矛
Future omen12(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“长矛”");
  await showOmenCard(12,blackhouseGame);
}
//13通灵板
Future omen13(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“通灵板”");
  await showOmenCard(13,blackhouseGame);
}
//14血石
Future omen14(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“血石”");
  await showOmenCard(14,blackhouseGame);
}
//15盒子
Future omen15(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“盒子”");
  await showOmenCard(15,blackhouseGame);
}
//16猫
Future omen16(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“猫”");
  await showOmenCard(16,blackhouseGame);
}
//17钥匙
Future omen17(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“钥匙”");
  await showOmenCard(17,blackhouseGame);
}
//18信
Future omen18(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“信”");
  await showOmenCard(18,blackhouseGame);
}
//19照片
Future omen19(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“照片”");
  await showOmenCard(19,blackhouseGame);
}
//20绳索
Future omen20(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“绳索”");
  await showOmenCard(20,blackhouseGame);
}
//21小瓶
Future omen21(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}遇到了征兆“小瓶”");
  await showOmenCard(21,blackhouseGame);
}
