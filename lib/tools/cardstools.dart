import 'package:blackhouse/cards/eventCards/ChooseWidget.dart';
import 'package:blackhouse/cards/eventCards/DamageChooseAllWidget.dart';
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:blackhouse/maps/map.dart';
import 'package:blackhouse/persons/person.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:blackhouse/cards/eventCards/DamageChooseWidget.dart';
import 'package:flutter/material.dart';
import 'package:blackhouse/config/param.dart';
import 'package:blackhouse/maps/showLayers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void turnleft_90(BlackHouseGame blackhouseGame)
{
  blackhouseGame.currenchoosemap.rotationAngle +=90;
  int temp=blackhouseGame.currenchoosemap.leftdoor;
  blackhouseGame.currenchoosemap.leftdoor=blackhouseGame.currenchoosemap.downdoor;
  blackhouseGame.currenchoosemap.downdoor=blackhouseGame.currenchoosemap.rightdoor;
  blackhouseGame.currenchoosemap.rightdoor=blackhouseGame.currenchoosemap.updoor;
  blackhouseGame.currenchoosemap.updoor=temp;
}

void turnleft_180(BlackHouseGame blackhouseGame)
{
  blackhouseGame.currenchoosemap.rotationAngle +=180;
  int temp=blackhouseGame.currenchoosemap.leftdoor;
  int temp2=blackhouseGame.currenchoosemap.updoor;
  blackhouseGame.currenchoosemap.leftdoor=blackhouseGame.currenchoosemap.rightdoor;
  blackhouseGame.currenchoosemap.rightdoor=temp;
  blackhouseGame.currenchoosemap.updoor=blackhouseGame.currenchoosemap.downdoor;
  blackhouseGame.currenchoosemap.downdoor=temp2;
}

void turnleft_270(BlackHouseGame blackhouseGame)
{
  blackhouseGame.currenchoosemap.rotationAngle +=270;
  int temp=blackhouseGame.currenchoosemap.leftdoor;
  blackhouseGame.currenchoosemap.leftdoor=blackhouseGame.currenchoosemap.updoor;
  blackhouseGame.currenchoosemap.updoor=blackhouseGame.currenchoosemap.rightdoor;
  blackhouseGame.currenchoosemap.rightdoor=blackhouseGame.currenchoosemap.downdoor;
  blackhouseGame.currenchoosemap.downdoor=temp;
}

void turnright_90(BlackHouseGame blackhouseGame)
{
  blackhouseGame.currenchoosemap.rotationAngle +=90;
  int temp=blackhouseGame.currenchoosemap.leftdoor;
  blackhouseGame.currenchoosemap.leftdoor=blackhouseGame.currenchoosemap.downdoor;
  blackhouseGame.currenchoosemap.downdoor=blackhouseGame.currenchoosemap.rightdoor;
  blackhouseGame.currenchoosemap.rightdoor=blackhouseGame.currenchoosemap.updoor;
  blackhouseGame.currenchoosemap.updoor=temp;
}

//旋转90度
void turn90(BlackHouseGame blackhouseGame,Mapblock map)
{
  map.rotationAngle +=90;
  int temp=map.leftdoor;
  map.leftdoor=map.downdoor;
  map.downdoor=map.rightdoor;
  map.rightdoor=map.updoor;
  map.updoor=temp;
}

void turnright_180(BlackHouseGame blackhouseGame)
{
  blackhouseGame.currenchoosemap.rotationAngle +=180;
  int temp=blackhouseGame.currenchoosemap.leftdoor;
  int temp2=blackhouseGame.currenchoosemap.updoor;
  blackhouseGame.currenchoosemap.leftdoor=blackhouseGame.currenchoosemap.rightdoor;
  blackhouseGame.currenchoosemap.rightdoor=temp;
  blackhouseGame.currenchoosemap.updoor=blackhouseGame.currenchoosemap.downdoor;
  blackhouseGame.currenchoosemap.downdoor=temp2;
}

void trunright_270(BlackHouseGame blackhouseGame)
{
  blackhouseGame.currenchoosemap.rotationAngle +=270;
  int temp=blackhouseGame.currenchoosemap.leftdoor;
  blackhouseGame.currenchoosemap.leftdoor=blackhouseGame.currenchoosemap.updoor;
  blackhouseGame.currenchoosemap.updoor=blackhouseGame.currenchoosemap.rightdoor;
  blackhouseGame.currenchoosemap.rightdoor=blackhouseGame.currenchoosemap.downdoor;
  blackhouseGame.currenchoosemap.downdoor=temp;
}

void setnearbyrooms(BlackHouseGame blackhouseGame,Mapblock map)
{
  //判断新地图块的上下左右地图的门
  int newup_x=map.x;
  int newup_y=map.y-1;
  int newdown_x=map.x;
  int newdown_y=map.y+1;
  int newleft_x=map.x-1;
  int newleft_y=map.y;
  int newright_x=map.x+1;
  int newright_y=map.y;

  //新房间上面是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newup_x}_${newup_y}")&&(map.mapid!=100&&map.mapid!=101))
  {
    //设置上下关系
    map.theuproom=blackhouseGame.mapcoordinate["${map.currentlayer}_${newup_x}_${newup_y}"].mapid;
    blackhouseGame.maps[blackhouseGame.mapcoordinate["${map.currentlayer}_${newup_x}_${newup_y}"].mapid].thedownroom=map.mapid;
  }
  //再判断新房间下面是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newdown_x}_${newdown_y}")&&(map.mapid!=100&&map.mapid!=101))
  {
    //设置上下关系
    map.thedownroom=blackhouseGame.mapcoordinate["${map.currentlayer}_${newdown_x}_${newdown_y}"].mapid;

    blackhouseGame.maps[blackhouseGame.mapcoordinate["${map.currentlayer}_${newdown_x}_${newdown_y}"].mapid].theuproom=map.mapid;
  }
  //再判断新房间左边是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newleft_x}_${newleft_y}")&&(map.mapid!=100&&map.mapid!=101))
  {
    //设置左右关系
    map.theleftroom=blackhouseGame.mapcoordinate["${map.currentlayer}_${newleft_x}_${newleft_y}"].mapid;
    blackhouseGame.maps[blackhouseGame.mapcoordinate["${map.currentlayer}_${newleft_x}_${newleft_y}"].mapid].therightroom=map.mapid;
  }
  //再判断新房间右边是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newright_x}_${newright_y}")&&(map.mapid!=100&&map.mapid!=101))
  {
    //设置左右关系
    map.therightroom=blackhouseGame.mapcoordinate["${map.currentlayer}_${newright_x}_${newright_y}"].mapid;
    blackhouseGame.maps[blackhouseGame.mapcoordinate["${map.currentlayer}_${newright_x}_${newright_y}"].mapid].theleftroom=map.mapid;
  }
}

bool isleftmatch(BlackHouseGame blackhouseGame,Mapblock map,Mapblock mapnew)
{
  //判断新地图块的上下左右地图的门
  int newdown_x=map.x-1;
  int newdown_y=map.y+1;
  int newup_x=map.x-1;
  int newup_y=map.y-1;
  int newleft_x=map.x-2;
  int newleft_y=map.y;

  if(mapnew.rightdoor==0) return false;
  //新房间上面是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newup_x}_${newup_y}"))
  {
    //如果有房间，再判断上面左边房间的向下开门处
    int upleftroomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newup_x}_${newup_y}"].mapid;
    //如果没门，新房间向上开门处不能有门
    if(blackhouseGame.maps[upleftroomid].downdoor==0&&mapnew.updoor!=0)
      return false;
    //如果有门，新房间向上开门处必须有房间
    if(blackhouseGame.maps[upleftroomid].downdoor!=0&&mapnew.updoor==0)
      return false;
  }
  //再判断新房间下面是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newdown_x}_${newdown_y}"))
  {
    //如果有房间，再判断下面左边房间的向上开门处
    int downleftroomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newdown_x}_${newdown_y}"].mapid;
    //如果没门，新房间向下开门处不能有门
    if(blackhouseGame.maps[downleftroomid].updoor==0&&mapnew.downdoor!=0)
      return false;
    //如果有门，新房间向上开门处必须有房间
    if(blackhouseGame.maps[downleftroomid].updoor!=0&&mapnew.downdoor==0)
      return false;
  }

  //再判断新房间左边是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newleft_x}_${newleft_y}"))
  {
    //如果有房间，再判断下面左边房间的向上开门处
    int leftleftroomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newleft_x}_${newleft_y}"].mapid;
    if(blackhouseGame.maps[leftleftroomid].rightdoor==0&&mapnew.leftdoor!=0)
      return false;
    if(blackhouseGame.maps[leftleftroomid].rightdoor!=0&&mapnew.leftdoor==0)
      return false;
  }
  return true;
}

bool isrightmatch(BlackHouseGame blackhouseGame,Mapblock map,Mapblock mapnew)
{
  //判断新地图块的上下左右地图的门
  int newup_x=map.x+1;
  int newup_y=map.y-1;
  int newdown_x=map.x+1;
  int newdown_y=map.y+1;
  int newright_x=map.x+2;
  int newright_y=map.y;
  if(mapnew.leftdoor==0) return false;
  //新房间上面是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newup_x}_${newup_y}"))
  {
    //如果有房间，再判断上面左边房间的向下开门处
    int uproomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newup_x}_${newup_y}"].mapid;
    //如果没门，新房间向上开门处不能有门
    if(blackhouseGame.maps[uproomid].downdoor==0&&mapnew.updoor!=0)
      return false;
    //如果有门，新房间向上开门处必须有房间
    if(blackhouseGame.maps[uproomid].downdoor!=0&&mapnew.updoor==0)
      return false;
  }
  //再判断新房间下面是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newdown_x}_${newdown_y}"))
  {
    //如果有房间，再判断下面左边房间的向上开门处
    int downroomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newdown_x}_${newdown_y}"].mapid;
    //如果没门，新房间向下开门处不能有门
    if(blackhouseGame.maps[downroomid].updoor==0&&mapnew.downdoor!=0)
      return false;
    //如果有门，新房间向上开门处必须有房间
    if(blackhouseGame.maps[downroomid].updoor!=0&&mapnew.downdoor==0)
      return false;
  }

  //再判断新房间右边是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newright_x}_${newright_y}"))
  {
    //如果有房间，再判断下面右边房间的左开门处
    int rightroomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newright_x}_${newright_y}"].mapid;
    if(blackhouseGame.maps[rightroomid].leftdoor==0&&mapnew.rightdoor!=0)
      return false;

    if(blackhouseGame.maps[rightroomid].leftdoor!=0&&mapnew.rightdoor==0)
      return false;
  }
  return true;
}

bool isupmatch(BlackHouseGame blackhouseGame,Mapblock map,Mapblock mapnew)
{
  //判断新地图块的上下左右地图的门
  int newleft_x=map.x-1;
  int newleft_y=map.y-1;
  int newup_x=map.x;
  int newup_y=map.y-2;
  int newright_x=map.x+1;
  int newright_y=map.y-1;
  if(mapnew.downdoor==0) return false;
  //新房间下面是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newup_x}_${newup_y}"))
  {
    int downroomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newup_x}_${newup_y}"].mapid;
    if(blackhouseGame.maps[downroomid].downdoor==0&&mapnew.updoor!=0)
      return false;
    if(blackhouseGame.maps[downroomid].downdoor!=0&&mapnew.updoor==0)
      return false;
  }

  //再判断新房间左边是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newleft_x}_${newleft_y}"))
  {
    //如果有房间，再判断下面左边房间的向上开门处
    int leftleftroomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newleft_x}_${newleft_y}"].mapid;
    //如果没门，新房间向下开门处不能有门
    if(blackhouseGame.maps[leftleftroomid].rightdoor==0&&mapnew.leftdoor!=0)
      return false;
    //如果有门，新房间向上开门处必须有房间
    if(blackhouseGame.maps[leftleftroomid].rightdoor!=0&&mapnew.leftdoor==0)
      return false;
  }

  //再判断新房间右边是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newright_x}_${newright_y}"))
  {
    //如果有房间，再判断下面右边房间的左开门处
    int rightroomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newright_x}_${newright_y}"].mapid;
    if(blackhouseGame.maps[rightroomid].leftdoor==0&&mapnew.rightdoor!=0)
      return false;

    if(blackhouseGame.maps[rightroomid].leftdoor!=0&&mapnew.rightdoor==0)
      return false;
  }
  return true;
}

bool isdownmatch(BlackHouseGame blackhouseGame,Mapblock map,Mapblock mapnew)
{
  //判断新地图块的上下左右地图的门
  int newleft_x=map.x-1;
  int newleft_y=map.y+1;
  int newdown_x=map.x;
  int newdown_y=map.y+2;
  int newright_x=map.x+1;
  int newright_y=map.y+1;
  if(mapnew.updoor==0) return false;
  //新房间上面是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newdown_x}_${newdown_y}"))
  {
    int downroomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newdown_x}_${newdown_y}"].mapid;
    if(blackhouseGame.maps[downroomid].updoor==0&&mapnew.downdoor!=0)
      return false;
    if(blackhouseGame.maps[downroomid].updoor!=0&&mapnew.downdoor==0)
      return false;
  }

  //再判断新房间左边是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newleft_x}_${newleft_y}"))
  {
    //如果有房间，再判断下面左边房间的向上开门处
    int leftleftroomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newleft_x}_${newleft_y}"].mapid;
    //如果没门，新房间向下开门处不能有门
    if(blackhouseGame.maps[leftleftroomid].rightdoor==0&&mapnew.leftdoor!=0)
      return false;
    //如果有门，新房间向上开门处必须有房间
    if(blackhouseGame.maps[leftleftroomid].rightdoor!=0&&mapnew.leftdoor==0)
      return false;
  }

  //再判断新房间右边是否有房间
  if(blackhouseGame.mapcoordinate.containsKey("${map.currentlayer}_${newright_x}_${newright_y}"))
  {
    //如果有房间，再判断下面右边房间的左开门处
    int rightroomid=blackhouseGame.mapcoordinate["${map.currentlayer}_${newright_x}_${newright_y}"].mapid;
    if(blackhouseGame.maps[rightroomid].leftdoor==0&&mapnew.rightdoor!=0)
      return false;

    if(blackhouseGame.maps[rightroomid].leftdoor!=0&&mapnew.rightdoor==0)
      return false;
  }
  return true;
}


//新地图块有适合的门
List<int> isDoorMacthedMaps(BlackHouseGame blackhouseGame,Mapblock judgemap,String need)
{
  List<int> roomslist=[];
  for(int i=1;i<=67;i++)
  {
    if(blackhouseGame.maps[i].isopen==false)
    {if(((judgemap.currentlayer==1&&blackhouseGame.maps[i].ifsetunderground)
        ||(judgemap.currentlayer==2&&blackhouseGame.maps[i].ifsetground)
        ||(judgemap.currentlayer==3&&blackhouseGame.maps[i].ifsetupground)
        ||(judgemap.currentlayer==4&&blackhouseGame.maps[i].ifsettopground)))
    {
      bool ismatch=false;
      for(int j=0;j<4;j++) {
        if(need=="up"&&blackhouseGame.maps[i].downdoor!=0)
        {
          if(!isupmatch(blackhouseGame,judgemap,blackhouseGame.maps[i])) {
            turn90(blackhouseGame,blackhouseGame.maps[i]);
            continue;
          }
          else
          {
            ismatch=true;
            break;
          }
        }
        else if(need=="down"&&blackhouseGame.maps[i].updoor!=0)
          {
            if(!isdownmatch(blackhouseGame,judgemap,blackhouseGame.maps[i])) {
              turn90(blackhouseGame,blackhouseGame.maps[i]);
              continue;
            }
            else
            {
              ismatch=true;
              break;
            }
          }
        else if(need=="left"&&blackhouseGame.maps[i].rightdoor!=0)
        {
          if(!isleftmatch(blackhouseGame,judgemap,blackhouseGame.maps[i])) {
            turn90(blackhouseGame,blackhouseGame.maps[i]);
            continue;
          }
          else
          {
            ismatch=true;
            break;
          }
        }
        else if(need=="right"&&blackhouseGame.maps[i].rightdoor!=0)
        {
          if(!isrightmatch(blackhouseGame,judgemap,blackhouseGame.maps[i])) {
            turn90(blackhouseGame,blackhouseGame.maps[i]);
            continue;
          }
          else
          {
            ismatch=true;
            break;
          }
        }
        else{
          turn90(blackhouseGame,blackhouseGame.maps[i]);
          continue;
        }
      }
      if(ismatch)
        roomslist.add(i);
    }
    }
  }
  return roomslist;
}

//掷骰子
Future<int> rollTheDice(BlackHouseGame blackhouseGame,int num) async{
  int totaldice=0;
  List<int> dicelist = new List();
  for(int i=0;i<num;i++) {
    dicelist.insert(i, 0);
  }

  //先让骰子转起来
  for(int i=1;i<=num;i++)
  {
    blackhouseGame.dicesmap[i].actionshow=true;
  }
  //动画效果停2秒
  await Future.delayed(const Duration(milliseconds: 1000), () {
  });

  //然后再掷骰子
  for(int i=1;i<=8;i++)
  {
    if(i<=num) {
      var dicerandom = new Random();
      int num = dicerandom.nextInt(3);
      dicelist[i-1]=num;
      blackhouseGame.dicesmap[i].diceNum=num;
      blackhouseGame.dicesmap[i].diceshow=true;
      blackhouseGame.dicesmap[i].actionshow=false;
    }
    else
    {
      blackhouseGame.dicesmap[i].actionshow=false;
      blackhouseGame.dicesmap[i].diceshow=false;
      blackhouseGame.dicesmap[i].diceNum=0;
    }
  }

  //动画效果停2秒
  await Future.delayed(const Duration(milliseconds: 1000), () {
  });

  for(int i=1;i<=dicelist.length;i++)
  {
    blackhouseGame.dicesmap[i].actionshow=false;
    blackhouseGame.dicesmap[i].diceshow=false;
    totaldice =totaldice+dicelist[i-1];
  }
  return totaldice;
}

//弹出提示框
Future showToast(String text) async{
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
  await Future.delayed(const Duration(milliseconds: 1000), () {
  });
}

Future showToast2(String text) async{
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

//展示事件卡牌
Future showEventCard(int i,BlackHouseGame blackhouseGame) async{
  blackhouseGame.currentEventCardID=i;
  blackhouseGame.currentEventCard=blackhouseGame.eventsmap[blackhouseGame.currentEventCardID];
  blackhouseGame.iseventCardShow=true;

  await Future.delayed(const Duration(milliseconds: 3000), () {
  });
  blackhouseGame.iseventCardShow=false;
}

//展示物品卡牌
Future showItemCard(int i,BlackHouseGame blackhouseGame) async{
  blackhouseGame.currentItemCardID=i;
  blackhouseGame.currentItemCard=blackhouseGame.itemsmap[blackhouseGame.currentItemCardID];
  blackhouseGame.isitemCardShow=true;

  await Future.delayed(const Duration(milliseconds: 3000), () {
  });
  blackhouseGame.isitemCardShow=false;
}

//展示预兆卡牌
Future showOmenCard(int i,BlackHouseGame blackhouseGame) async{
  blackhouseGame.currentOmenCardID=i;
  blackhouseGame.currentOmenCard=blackhouseGame.omensmap[blackhouseGame.currentOmenCardID];
  blackhouseGame.isomenCardShow=true;

  await Future.delayed(const Duration(milliseconds: 3000), () {
  });
  blackhouseGame.isomenCardShow=false;
}

//检定掷骰子，diceNum,检测的属性点，type:0，随机掷骰子，1，结果指定
Future<int> getDiceNum(BuildContext context,BlackHouseGame blackhouseGame,int currentplayerID,int diceNum,int type) async{
  int playerTotalDice=0;

  playerTotalDice=await rollTheDice(blackhouseGame,diceNum);
  if(type==0) {
    await showToast("掷骰子结果为${playerTotalDice}点");
    return playerTotalDice;
  }
  else {
    //有蓝图
    if(blackhouseGame.persons[currentplayerID].itemlist.contains(1)) {
      await showToast("掷骰子结果为${playerTotalDice}点，您有物品[蓝图]，是否自主选择掷骰子的结果");
    }
  }
}

//精神伤害
Future MentalDamage(BuildContext context,BlackHouseGame blackhouseGame,int dice,int currentplayerID) async{
  String currentplayername=blackhouseGame.persons[currentplayerID].playername;
  int num_sanity=blackhouseGame.persons[currentplayerID].currentsanity;
  int num_knowledge=blackhouseGame.persons[currentplayerID].currentknowledge;
  await chooseMentalDamage(context, num_sanity, num_knowledge, "神志", "知识", dice);

  blackhouseGame.persons[currentplayerID].currentsanity=numAfterDamage_1;
  blackhouseGame.persons[currentplayerID].currentknowledge=numAfterDamage_2;
  numAfterDamage_1=0;
  numAfterDamage_2=0;

  await showToast("精神伤害掷骰子结果为${dice}点，受到$dice点精神伤害,玩家${currentplayername}"
      "神志减少${num_sanity-blackhouseGame.persons[currentplayerID].currentsanity}级;"
      "知识减少${num_knowledge-blackhouseGame.persons[currentplayerID].currentknowledge}级");
}

//精神伤害直接传入骰子数
Future MantalDamageByDiceNum(BuildContext context,int diceNum,BlackHouseGame blackhouseGame,int currentplayerID) async{
  int playerTotalDice=0;

  playerTotalDice=await rollTheDice(blackhouseGame,diceNum);

  if(playerTotalDice>0)
    await MentalDamage(context,blackhouseGame,playerTotalDice,currentplayerID);
  else
    await showToast("掷骰子结果为${playerTotalDice}点，不必受到精神伤害");
}

//肉体伤害
Future BodyDamage(BuildContext context,BlackHouseGame blackhouseGame,int dice,int currentplayerID) async{
  String currentplayername=blackhouseGame.persons[currentplayerID].playername;

  int num_might=blackhouseGame.persons[currentplayerID].currentmight;
  int num_speed=blackhouseGame.persons[currentplayerID].currentspeed;
  await chooseMentalDamage(context, num_might, num_speed, "力量", "速度", dice);

  blackhouseGame.persons[currentplayerID].currentmight=numAfterDamage_1;
  blackhouseGame.persons[currentplayerID].currentspeed=numAfterDamage_2;
  numAfterDamage_1=0;
  numAfterDamage_2=0;

  await showToast("肉体伤害掷骰子结果为${dice}点，受到$dice点肉体伤害,玩家${currentplayername}"
      "力量减少${num_might-blackhouseGame.persons[currentplayerID].currentmight}级;"
      "速度减少${num_speed-blackhouseGame.persons[currentplayerID].currentspeed}级");
}

//肉体伤害直接传入骰子数
Future BodyDamageByDiceNum(BuildContext context,int diceNum,BlackHouseGame blackhouseGame,int currentplayerID) async{
  int playerTotalDice=0;

  playerTotalDice=await rollTheDice(blackhouseGame,diceNum);
  if(playerTotalDice>0)
    await BodyDamage(context,blackhouseGame,playerTotalDice,currentplayerID);
  else
    await showToast("掷骰子结果为${playerTotalDice}点，不必受到肉体伤害");
}

//精神伤害选择
Future chooseMentalDamage(BuildContext context,int DamageNum_1,int DamageNum_2,String text_1,String text_2,int totalDamage) async{
  var result = await showDialog(
      barrierDismissible:false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: DamageChooseWidget(DamageNum_1,DamageNum_2,text_1,text_2,totalDamage),
          actions: <Widget>[
            FlatButton(
              child: Text('确认'),
              onPressed: () async{
                if(numTotalAfterDamage>0)
                {
                  await showToast("当前属性点未分配");
                  return;
                }
                else
                  Navigator.of(context).pop('ok');
              },
            ),
          ],
        );
      });
  return result;
}

//检定伤害选择(by hxd)
Future<int> chooseMentalDamageAll(BuildContext context,Person person,{List list}) async{
  int chose = 0;
  await showDialog(
      barrierDismissible:false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: DamageChooseAllWidget(person,list),
          actions: <Widget>[
            FlatButton(
              child: Text('确认'),
              onPressed: () async{
                chose = DamageChooseAllWidgetState.chose;
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
  return chose;
}

//确认框(by hxd)
Future<int> choseDialog(BuildContext context,String title) async{
  int chose = 0;
  await showDialog(
      barrierDismissible:false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: ChooseWidget(title),
          actions: <Widget>[
            FlatButton(
              child: Text('确认'),
              onPressed: () async{
                chose = 1;
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('取消'),
              onPressed: () async{
                chose = 0;
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
  return chose;
}

//袭击函数
Future fight(BlackHouseGame blackhouseGame,int player1,int player2, int player1_might, int player2_might) async{
  int player1TotalDice=0;
  int player2TotalDice=0;
  await showToast("玩家${blackhouseGame.persons[player1].playername}当前力量值为${player1_might},掷${blackhouseGame.persons[player1].currentmight}颗骰子");

  player1TotalDice=await rollTheDice(blackhouseGame,player1_might);

  await showToast("玩家${blackhouseGame.persons[player2].playername}当前力量值为${player2_might},掷${blackhouseGame.persons[player2].currentmight}颗骰子");

  player2TotalDice=await rollTheDice(blackhouseGame,player2_might);

  if(player1TotalDice-player2TotalDice>0)
  {
    await showToast("玩家${blackhouseGame.persons[player1].playername}总骰子数为${player1TotalDice}");
    await showToast("玩家${blackhouseGame.persons[player2].playername}总骰子数为${player2TotalDice}");
    await showToast("玩家${blackhouseGame.persons[player1].playername}胜玩家${blackhouseGame.persons[player2].playername} ${player1TotalDice-player2TotalDice}点");
    await showToast("玩家${blackhouseGame.persons[player2].playername}受到 ${player1TotalDice-player2TotalDice}点力量伤害");
    blackhouseGame.persons[player2].currentmight=blackhouseGame.persons[player2].currentmight-(player1TotalDice-player2TotalDice);
    if(blackhouseGame.persons[player2].currentmight<0)
      blackhouseGame.persons[player2].currentmight=0;
  }
  else  if(player2TotalDice-player1TotalDice>0)
  {
    await showToast("玩家${blackhouseGame.persons[player2].playername}总骰子数为${player2TotalDice}");
    await showToast("玩家${blackhouseGame.persons[player1].playername}总骰子数为${player1TotalDice}");
    await showToast("玩家${blackhouseGame.persons[player2].playername}胜玩家${blackhouseGame.persons[player1].playername} ${player2TotalDice-player1TotalDice}点");
    await showToast("玩家${blackhouseGame.persons[player1].playername}受到 ${player2TotalDice-player1TotalDice}点力量伤害");
    blackhouseGame.persons[player1].currentmight=blackhouseGame.persons[player1].currentmight-(player2TotalDice-player1TotalDice);
    if(blackhouseGame.persons[player1].currentmight<0)
      blackhouseGame.persons[player1].currentmight=0;
  }
  else
  {
    await showToast("玩家${blackhouseGame.persons[player1].playername}和玩家${blackhouseGame.persons[player2].playername}掷骰子数相同，都是${player2TotalDice}点，平局");
  }
}


//滑道放置
Future setHuaDao(BuildContext context,BlackHouseGame blackhouseGame,int player) async{
  //用力量来使用滑道
  int might=blackhouseGame.persons[player].currentmight;
  //力量5+, 滑到下一层任意已经探索到的房间
  if(might>=5)
    {
      await showToast("力量大于5，请选择滑到下一层任意已经探索到的房间");
      int mapid=blackhouseGame.persons[player].currentmapid;
      int layer=blackhouseGame.maps[mapid].currentlayer-1;
      await showLayer(blackhouseGame,layer);
    }
  else if(might>=0&&might<=4)
    {
      //地下室是否有可用房间
       List<int> maplist=await hasMaps(blackhouseGame,1);
       print("maplistlength${maplist.length}");
       //如果有，则抽取房间
       if(maplist.length>0) {
         await showToast("请选择下一层任意房间开门出进行房间探索");
         await chooseRoomDoorsOfLayer(blackhouseGame, 1);
         //如果没有掉落到一个房间，收到1点精神伤害
       }
       else
         {
           await showToast("请选择掉落到地下室已经探索到的房间");
           await showLayer(blackhouseGame,1);
           await showToast("受到1骰子物理伤害");
           await BodyDamageByDiceNum(context,1,blackhouseGame,player);
         }
    }
}

//丢弃物品卡， itemID为0时随机舍弃
int abandonItem(int itemID,BuildContext context,BlackHouseGame blackhouseGame,int playerID) {
  if(itemID==0) {
    int num = blackhouseGame.persons[playerID].itemlist.length;
    var random = new Random();
    num = random.nextInt(num);
    itemID = blackhouseGame.persons[playerID].itemlist[num];
  }
  blackhouseGame.persons[playerID].itemlist.removeAt(itemID);
  blackhouseGame.itemsmap[itemID].ownerid=0;
  return itemID;
}

//抽房卡
int chooseRoom(List<int> roomslist)
{
  int i=0;
  if(setChooseOpenRoom!=0)
    i=setChooseOpenRoom;
  else {
    var rng = new Random();
    int num = rng.nextInt(roomslist.length);
    i = roomslist[num];
  }

  setChooseOpenRoom=0;
  return i;
}



