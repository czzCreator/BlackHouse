//显示指定的层

import 'package:blackhouse/game/blackhousegame.dart';
import 'package:blackhouse/config/param.dart';
import 'package:flutter/cupertino.dart';
import 'package:blackhouse/tools/cardstools.dart';
import 'dart:math';

Future showLayer(BlackHouseGame blackhouseGame,int layer) async{

  ischooseroom=true;   //打开开关，便于balckhousegame.dart中的onTap函数判断
  blackhouseGame.isshowlittemap=true;
  choosedMapID=0;
  templeftid=blackhouseGame.currentleftmap.mapid;
  tempmiddleid=blackhouseGame.currentmiddlemap.mapid;
  temprightid=blackhouseGame.currentrightmap.mapid;

  blackhouseGame.showlayer=layer;

  blackhouseGame.currentleftmap=null;
  blackhouseGame.currentmiddlemap=null;
  blackhouseGame.currentrightmap=null;
  blackhouseGame.currenchoosemap=null;

  blackhouseGame.showtips=true;
  int waitTime=10;
  await showToast("请点击要选择的房间");

  while(choosedMapID==0&&waitTime!=0)
  {
    blackhouseGame.tips="等待玩家选择房间，剩余${waitTime}秒";
    await Future.delayed(const Duration(milliseconds: 1000), () {
    });
    waitTime--;
    print(choosedMapID);
  }

  //玩家没操作，自动随机选择
  if(choosedMapID==0) {
    List<int> maplist = new List();
    blackhouseGame.mapcoordinate.forEach((key, value) async {
      if (key.split("_")[0] == "${blackhouseGame.showlayer}") {
        String keystr = "${(value.x + 4) * 80}_${(value.y + 4) *
            80}";
        int mapid = blackhouseGame.littemaps[keystr].mapid;
        maplist.add(mapid);
      }
    });
    var random = new Random();
    int num = random.nextInt(maplist.length);
    choosedMapID=maplist[num];
  }

  ischooseroom=false;
  //通过背景文字绘制提示
  blackhouseGame.showtips=false;
  blackhouseGame.tips="";

  if(choosedMapID!=0)
    await showToast("选择了地图${blackhouseGame.maps[choosedMapID].roomname}");

  blackhouseGame.currentleftmap=blackhouseGame.maps[templeftid];
  blackhouseGame.currentmiddlemap=blackhouseGame.maps[tempmiddleid];
  blackhouseGame.currentrightmap=blackhouseGame.maps[temprightid];
  blackhouseGame.isshowlittemap=false;
  return true;
}

//是否有可用的门/是否封闭
Future<List<String> > hasOpenDoors(BlackHouseGame blackhouseGame,int layer) async{

  refreshLittleMap(blackhouseGame,layer);
  List<String> maplist = new List();
  blackhouseGame.mapcoordinate.forEach((key, value) async {
    if (key.split("_")[0] == "${layer}") {
      String keystr = "${(value.x + 4) * 80}_${(value.y + 4) *
          80}"; //自己存的坐标和界面坐标y是相反的
      if (blackhouseGame.littemaps.containsKey(keystr)) {
        int mapid = blackhouseGame.littemaps[keystr].mapid;
        if (blackhouseGame.maps[mapid].theleftroom == 0 &&
            blackhouseGame.maps[mapid].leftdoor != 0) {
          maplist.add("$mapid||1");
        }
        if (blackhouseGame.maps[mapid].theuproom == 0 &&
            blackhouseGame.maps[mapid].updoor != 0) {
          maplist.add("$mapid||2");
        }
        if (blackhouseGame.maps[mapid].therightroom == 0 &&
            blackhouseGame.maps[mapid].rightdoor != 0) {
          maplist.add("$mapid||3");
        }
        if (blackhouseGame.maps[mapid].thedownroom == 0 &&
            blackhouseGame.maps[mapid].downdoor != 0) {
          maplist.add("$mapid||4");
        }
      }
    }
  });

  //list为空的时候不可用
  return maplist;
}

void refreshLittleMap(BlackHouseGame blackhouseGame,int layer)
{
  blackhouseGame.mapcoordinate.forEach((key, value) {
    if ((key.split("_")[0] == ("1") && layer == 1)
        || (key.split("_")[0] == ("2") && layer == 2)
        || (key.split("_")[0] == ("3") && layer == 3)
        || (key.split("_")[0] == ("4") && layer == 4)) {
      String keystr = "${(value.x + 4) * 80}_${(value.y + 4) *
          80}";
      blackhouseGame.littemaps[keystr] = blackhouseGame.maps[value.mapid];
    }
  });
}


//是否有可抽取的地图块
Future<List<int> > hasMaps(BlackHouseGame blackhouseGame,int layer) async{
  List<int> maplist=new List();
  List<String> doorlist = await hasOpenDoors(blackhouseGame,layer);
  if(doorlist==0) {
    await showToast("当前无可探索的房间，直接掉落到已探索的房间中");
    return maplist;
  }

  List<int> retmaplist=new List();
  for(int i=0;i<doorlist.length;i++)
    {
      int mapid=int.parse(doorlist[i].split("||")[0]);
      int doorid=int.parse(doorlist[i].split("||")[1]);
      if(doorid==1)
        maplist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.maps[mapid],"right");
      else  if(doorid==2)
        maplist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.maps[mapid],"down");
      else  if(doorid==3)
        maplist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.maps[mapid],"left");
      else  if(doorid==2)
        maplist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.maps[mapid],"up");

      for(int j=0;j<maplist.length;j++)
        {
          if(!retmaplist.contains(maplist[i]))
            retmaplist.add(maplist[i]);
        }
    }
  return retmaplist;
}

//根据给出的层数选择房间
Future chooseRoomDoorsOfLayer(BlackHouseGame blackhouseGame,int layer) async{

  ischooseRoomDoor=true;   //打开开关，便于balckhousegame.dart中的onTap函数判断，以及小地图画图
  choosedMapID=0;
  chooseMapDoor=0;
  templeftid=blackhouseGame.currentleftmap.mapid;
  tempmiddleid=blackhouseGame.currentmiddlemap.mapid;
  temprightid=blackhouseGame.currentrightmap.mapid;

  blackhouseGame.showlayer=layer;

  blackhouseGame.currentleftmap=null;
  blackhouseGame.currentmiddlemap=null;
  blackhouseGame.currentrightmap=null;
  blackhouseGame.currenchoosemap=null;
  blackhouseGame.isshowlittemap=true;
  blackhouseGame.showtips=true;
  int waitTime=6;
  await showToast("请点击要选择的房间门");

  while(choosedMapID==0&&chooseMapDoor==0&&waitTime!=0)
  {
    blackhouseGame.tips="等待玩家选择房间连接门，剩余${waitTime}秒";
    await Future.delayed(const Duration(milliseconds: 1000), () {
    });
    waitTime--;
  }

  //玩家没操作，自动随机选择
  if(choosedMapID==0) {
    List<String> maplist = new List();
    blackhouseGame.tips = "系统正在随机选择房间……";
    blackhouseGame.mapcoordinate.forEach((key, value) async {
      if (key.split("_")[0] == "${blackhouseGame.showlayer}") {
        String keystr = "${(value.x + 4) * 80}_${(value.y + 4) *
            80}"; //自己存的坐标和界面坐标y是相反的
        int mapid = blackhouseGame.littemaps[keystr].mapid;
        if(blackhouseGame.maps[mapid].theleftroom==0&&blackhouseGame.maps[mapid].leftdoor!=0)
        {
          maplist.add("$mapid||1");
        }
        if(blackhouseGame.maps[mapid].theuproom==0&&blackhouseGame.maps[mapid].updoor!=0)
        {
          maplist.add("$mapid||2");
        }
        if(blackhouseGame.maps[mapid].therightroom==0&&blackhouseGame.maps[mapid].rightdoor!=0)
        {
          maplist.add("$mapid||3");
        }
        if(blackhouseGame.maps[mapid].thedownroom==0&&blackhouseGame.maps[mapid].downdoor!=0)
        {
          maplist.add("$mapid||4");
        }
      }
    });
    var random = new Random();
    int num = random.nextInt(maplist.length);
    choosedMapID=int.parse(maplist[num].split("||")[0]);
    chooseMapDoor=int.parse(maplist[num].split("||")[1]);
  }

  ischooseRoomDoor=false;
  //通过背景文字绘制提示
  blackhouseGame.showtips=false;
  blackhouseGame.tips="";

  if(choosedMapID!=0)
    await showToast("选择了地图${blackhouseGame.maps[choosedMapID].roomname},门$chooseMapDoor");

  blackhouseGame.currentleftmap=blackhouseGame.maps[templeftid];
  blackhouseGame.currentmiddlemap=blackhouseGame.maps[tempmiddleid];
  blackhouseGame.currentrightmap=blackhouseGame.maps[temprightid];
  blackhouseGame.isshowlittemap=false;
  return true;
}

//根据给定的房间选择能放置的门
Future chooseRoomDoorsOfGivenRoom(BlackHouseGame blackhouseGame,int layer,int roomid) async{

  ischooseRoomDoor=true;   //打开开关，便于balckhousegame.dart中的onTap函数判断，以及小地图画图
  choosedMapID=0;
  chooseMapDoor=0;
  templeftid=blackhouseGame.currentleftmap.mapid;
  tempmiddleid=blackhouseGame.currentmiddlemap.mapid;
  temprightid=blackhouseGame.currentrightmap.mapid;

  blackhouseGame.showlayer=layer;

  blackhouseGame.currentleftmap=null;
  blackhouseGame.currentmiddlemap=null;
  blackhouseGame.currentrightmap=null;
  blackhouseGame.currenchoosemap=null;
  blackhouseGame.isshowlittemap=true;
  blackhouseGame.showtips=true;
  int waitTime=2;
  await showToast("系统正在随机选择天井位置");

  while(choosedMapID==0&&chooseMapDoor==0&&waitTime!=0)
  {
    await Future.delayed(const Duration(milliseconds: 1000), () {
    });
    waitTime--;
  }


  //玩家没操作，自动随机选择
  if(choosedMapID==0) {
    List<String> maplist = new List();
    blackhouseGame.tips = "……";
    blackhouseGame.mapcoordinate.forEach((key, value) async {
      if (key.split("_")[0] == "${blackhouseGame.showlayer}") {
        String keystr = "${(value.x + 4) * 80}_${(value.y + 4) *
            80}"; //自己存的坐标和界面坐标y是相反的
        int mapid = blackhouseGame.littemaps[keystr].mapid;
        if(blackhouseGame.maps[mapid].theleftroom==0&&blackhouseGame.maps[mapid].leftdoor!=0)
        {
          maplist.add("$mapid||1");
        }
        if(blackhouseGame.maps[mapid].theuproom==0&&blackhouseGame.maps[mapid].updoor!=0)
        {
          maplist.add("$mapid||2");
        }
        if(blackhouseGame.maps[mapid].therightroom==0&&blackhouseGame.maps[mapid].rightdoor!=0)
        {
          maplist.add("$mapid||3");
        }
        if(blackhouseGame.maps[mapid].thedownroom==0&&blackhouseGame.maps[mapid].downdoor!=0)
        {
          maplist.add("$mapid||4");
        }
      }
    });

    for(int i=0;i<maplist.length;i++)
    {
        choosedMapID=int.parse(maplist[i].split("||")[0]);
        chooseMapDoor=int.parse(maplist[i].split("||")[1]);
        String direct="0";
        if(chooseMapDoor==1) direct="left";
        else if(chooseMapDoor==2) direct="up";
        else if(chooseMapDoor==3) direct="right";
        else if(chooseMapDoor==4) direct="down";
        List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.maps[choosedMapID],direct);
        if(roomslist.contains(roomid))
          break;
        showToast("此门无法放置请选择其他门");
        choosedMapID=0;
        chooseMapDoor=0;
    }
  }

  ischooseRoomDoor=false;
  //通过背景文字绘制提示
  blackhouseGame.showtips=false;
  blackhouseGame.tips="";

  if(choosedMapID==0&&chooseMapDoor==0)
    await showToast("没有合适的地方放置指定地图，跳过事件卡牌效果");

  blackhouseGame.currentleftmap=blackhouseGame.maps[templeftid];
  blackhouseGame.currentmiddlemap=blackhouseGame.maps[tempmiddleid];
  blackhouseGame.currentrightmap=blackhouseGame.maps[temprightid];
  blackhouseGame.isshowlittemap=false;
  return true;
}

//显示相邻房间
Future shownearbyRooms(BlackHouseGame blackhouseGame,int layer) async{

  ischooseroom=true;   //打开开关，便于balckhousegame.dart中的onTap函数判断
  blackhouseGame.isshowlittemap=true;
  choosedMapID=0;
  templeftid=blackhouseGame.currentleftmap.mapid;
  tempmiddleid=blackhouseGame.currentmiddlemap.mapid;
  temprightid=blackhouseGame.currentrightmap.mapid;

  blackhouseGame.showlayer=layer;

  blackhouseGame.currentleftmap=null;
  blackhouseGame.currentmiddlemap=null;
  blackhouseGame.currentrightmap=null;
  blackhouseGame.currenchoosemap=null;

  blackhouseGame.showtips=true;
  int waitTime=10;
  await showToast("请点击要选择的房间");

  while(choosedMapID==0&&waitTime!=0)
  {
    blackhouseGame.tips="等待玩家选择房间，剩余${waitTime}秒";
    await Future.delayed(const Duration(milliseconds: 1000), () {
    });
    waitTime--;
    print(choosedMapID);
  }

  //玩家没操作，自动随机选择
  if(choosedMapID==0) {
    List<int> maplist = new List();
    blackhouseGame.mapcoordinate.forEach((key, value) async {
      if (key.split("_")[0] == "${blackhouseGame.showlayer}") {
        String keystr = "${(value.x + 4) * 80}_${(value.y + 4) *
            80}";
        int mapid = blackhouseGame.littemaps[keystr].mapid;
        maplist.add(mapid);
      }
    });
    var random = new Random();
    int num = random.nextInt(maplist.length);
    choosedMapID=maplist[num];
  }

  ischooseroom=false;
  //通过背景文字绘制提示
  blackhouseGame.showtips=false;
  blackhouseGame.tips="";

  if(choosedMapID!=0)
    await showToast("选择了地图${blackhouseGame.maps[choosedMapID].roomname}");

  blackhouseGame.currentleftmap=blackhouseGame.maps[templeftid];
  blackhouseGame.currentmiddlemap=blackhouseGame.maps[tempmiddleid];
  blackhouseGame.currentrightmap=blackhouseGame.maps[temprightid];
  blackhouseGame.isshowlittemap=false;
  return true;
}