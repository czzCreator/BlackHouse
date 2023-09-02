//物品牌操作
import 'package:blackhouse/game/blackhousegame.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:blackhouse/tools/cardstools.dart';
import 'chooseDiceNum.dart';
import 'package:blackhouse/config/param.dart';
import 'package:blackhouse/cards/itemsCards/emittheitem.dart' as ItemEmit;

//1蓝图
//抽取蓝图
Future items01(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“蓝图”");
  await showItemCard(1,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(1);
  blackhouseGame.itemsmap[1].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[1].choosemapid=mapid;
  blackhouseGame.itemsmap[1].isopen=true;

}

//是否使用卡牌效果
Future ifuseCard(BuildContext context,String cardName, String cardFuctionDetail) async{
  var result = await showDialog(
      barrierDismissible:false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('是否使用物品${cardName}的效果：${cardFuctionDetail}'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop('cancel');
              },
            ),
            FlatButton(
              child: Text('确认'),
              onPressed: () {
                Navigator.of(context).pop('ok');
              },
            ),
          ],
        );
      });
  return result;
}

//蓝图效果1：进入、离开、穿过房间行动掷骰子时，选择想要的结果
Future<int> items01_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
    String isusefuction=await ifuseCard(context,"蓝图","指定掷骰子的结果");
    if(isusefuction=="cancel") return -1;
    else
      {
        List<int> values=[];
        for (int i = 0; i <= diceNum*2; i++) {
          values.add(i);
        }
        var result = await showDialog(
            barrierDismissible:false,
            barrierColor: Colors.transparent,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('请指定想要的骰子点数'),
                actions: <Widget>[
              ChooseNum(1,values,blackhouseGame),
              FlatButton(
              child: Text('确认'),
              onPressed: () {
              if(chooseNum==-1)
              showToast("还未选择骰子点数，请选择点数");
              else {
                showToast("已选择点数$chooseNum为掷骰子结果");
                Navigator.of(context).pop(chooseNum);
              }
              },
              ),
              ],
              );
            });
        return result;
      }
}

//蓝图效果2：
Future<int> items01_effect02(BuildContext context,BlackHouseGame blackhouseGame)  async{
  String isusefuction=await ifuseCard(context,"蓝图","移动到有升降机的房间");
  if(isusefuction=="cancel") return -1;
  else
  {
    List<int> roomslist=[];
    for(int i=1;i<=67;i++)
    {
      if(blackhouseGame.maps[i].isopen==true&&blackhouseGame.maps[i].liftflags==1)
        roomslist.add(i);
    }

    if(roomslist.length==0) {
      showToast("没有发现升降梯的房间，不能使用此功能");
      return -1;
    }

    var result = await showDialog(
        barrierDismissible:false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('请指定要移动到的房间'),
            actions: <Widget>[
              ChooseNum(2,roomslist,blackhouseGame),
              FlatButton(
                child: Text('确认'),
                onPressed: () {
                  if(chooseNum==-1)
                    showToast("还未选择房间，请选择房间");
                  else {
                    showToast("已选择房间${blackhouseGame.maps[chooseNum].roomname}");
                    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=chooseNum;
                    Navigator.of(context).pop(chooseNum);
                  }
                },
              ),
            ],
          );
        });
    return result;
  }
}


//2扫帚柄
Future items02(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“扫帚柄”");
  await showItemCard(2,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(2);
  blackhouseGame.itemsmap[2].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[2].choosemapid=mapid;

  //武器
  blackhouseGame.itemsmap[2].iswepon=true;
  //置物品标志
  blackhouseGame.itemsmap[2].itemflags=2;
  blackhouseGame.itemsmap[2].isopen=true;

}

//扫帚柄效果1
Future<int> items02_effect01(BuildContext context,BlackHouseGame blackhouseGame)  async{
  String isusefuction=await ifuseCard(context,"扫帚柄","是否用速度7的攻击替换力量攻击");
  if(isusefuction=="cancel") return -1;
  else
  {
    var result=7;
    blackhouseGame.itemsmap[2].itemflags -=1;
    //使用2次后丢弃
    if(blackhouseGame.itemsmap[2].itemflags==0) {
      await showToast("物品“扫帚柄”已使用两次，被丢弃");
      blackhouseGame.itemsmap[2].ownerid = 0;
      for(int i=0;i<blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.length;i++)
        {
          if(blackhouseGame.persons[blackhouseGame.currentplayer].itemlist[i]==2){
            blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.removeAt(i);
            break;
          }
        }
    }
    return result;
  }
}


//3手持摄像机
Future items03(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“手持摄像机”");
  await showItemCard(3,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(3);
  blackhouseGame.itemsmap[3].ownerid=0;  //为0则放在房间
  blackhouseGame.itemsmap[3].choosemapid=mapid;
  blackhouseGame.itemsmap[3].knowledgeflags=7;
  blackhouseGame.itemsmap[3].isopen=true;

}

//手持摄像机效果
Future<int> items03_effect01(BuildContext context,BlackHouseGame blackhouseGame)  async{
  //玩家已拥有则不能获取
  if(blackhouseGame.itemsmap[3].knowledgeflagplayers.contains(blackhouseGame.currentplayer))
    return 0;
  String isusefuction="cancel";
  if(blackhouseGame.itemsmap[3].knowledgeflags>1)
    isusefuction=await ifuseCard(context,"手持摄像机","是否获取知识考验标记");
  else if(blackhouseGame.itemsmap[3].knowledgeflags==1)
    isusefuction=await ifuseCard(context,"手持摄像机知识标志只剩一个","拿取后所有其他玩家知识会下降一个等级，是否拿去");

  if(isusefuction=="cancel") return -1;
  else
  {
    if(blackhouseGame.itemsmap[3].knowledgeflags>1){
    await showToast("玩家获取一个知识考验标记，知识提升一级");
    blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge+= 1;
    //标志数减1
    blackhouseGame.itemsmap[3].knowledgeflags -=1;
    blackhouseGame.itemsmap[3].knowledgeflagplayers.add(blackhouseGame.currentplayer);
    }
    else if(blackhouseGame.itemsmap[3].knowledgeflags==1){
    //如果标志都被领取，则丢弃此卡，和知识考验标志，所有玩家知识下降1级
    if(blackhouseGame.itemsmap[3].knowledgeflags==0) {
      await showToast("物品“手持摄像机”知识标记被拿完，将被丢弃，所有拿取知识标记的玩家知识下降1级");
      for(int i=0;i<blackhouseGame.itemsmap[3].knowledgeflagplayers.length;i++)
        {
          if(blackhouseGame.persons[blackhouseGame.itemsmap[3].knowledgeflagplayers[i]].currentknowledge>1)
          blackhouseGame.persons[blackhouseGame.itemsmap[3].knowledgeflagplayers[i]].currentknowledge-= 1;
        }
      blackhouseGame.itemsmap[3].ownerid = 0;
      blackhouseGame.itemsmap[3].choosemapid = 0;
    }
    }
    return 0;
  }
}

//4仪式长袍
Future items04(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“仪式长袍”");
  await showItemCard(4,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(4);
  blackhouseGame.itemsmap[4].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[4].choosemapid=mapid;
  blackhouseGame.itemsmap[4].isopen=true;
}


//仪式长袍效果
Future<int> items04_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  String isusefuction=await ifuseCard(context,"仪式长袍","是否重置指定数量的骰子");
  if(isusefuction=="cancel") return -1;
  else
  {
    List<int> values=[];
    for (int i = 1; i <= diceNum; i++) {
      values.add(i);
    }
    var result = await showDialog(
        barrierDismissible:false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('请指定想要重掷的骰子数'),
            actions: <Widget>[
              ChooseNum(1,values,blackhouseGame),
              FlatButton(
                child: Text('确认'),
                onPressed: () {
                  if(chooseNum==-1)
                    showToast("还未选择骰子数，请选择");
                  else {
                    showToast("已选择重掷$chooseNum个骰子");
                    Navigator.of(context).pop(chooseNum);
                  }
                },
              ),
            ],
          );
        });
    return result;
  }
}


//5电锯
Future items05(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“电锯”");
  await showItemCard(5,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(5);
  blackhouseGame.itemsmap[5].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[5].choosemapid=mapid;

  //武器
  blackhouseGame.itemsmap[5].iswepon=true;
  blackhouseGame.itemsmap[5].isopen=true;
}

//电锯效果
Future<int> items05_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  String isusefuction=await ifuseCard(context,"电锯","是否使用电锯为力量掷骰子增加1枚骰子");
  if(isusefuction=="cancel") return 0;
  else
  {

    return 1;
  }
}

//6粉笔
Future items06(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“粉笔”");
  await showItemCard(6,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(6);
  blackhouseGame.itemsmap[6].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[6].choosemapid=mapid;
  blackhouseGame.itemsmap[6].isopen=true;
}


//粉笔效果
Future<int> items06_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  int currentmight=blackhouseGame.persons[blackhouseGame.itemsmap[6].ownerid].currentmight;
  int currentknowledge=blackhouseGame.persons[blackhouseGame.itemsmap[6].ownerid].currentknowledge;
  String isusefuction=await ifuseCard(context,"粉笔","防御掷骰子是否知识代替力量");
  if(isusefuction=="cancel") return currentmight;
  else
  {
    showToast("玩家使用知识代替力量进行防御");
    return currentknowledge;
  }
}

//7装置
Future items07(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“装置”");
  await showItemCard(7,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(7);
  blackhouseGame.itemsmap[7].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[7].choosemapid=mapid;
  blackhouseGame.itemsmap[7].isopen=true;
}

//装置效果1：回合结束时，如果和敌人处于一个房间，提升1级知识
Future<int> items07_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  await showToast("装置效果触发，玩家和敌人处于一间房间，提升一级知识");
  blackhouseGame.persons[blackhouseGame.itemsmap[7].ownerid].currentknowledge +=1;
  return 0;
}

//装置效果2： 偷窃攻击时，可以丢弃此牌增加3个骰子
Future<int> items07_effect02(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  String isusefuction=await ifuseCard(context,"装置","是否丢弃装置为偷窃攻击掷骰子增加3枚骰子");
  if(isusefuction=="cancel") return -1;
  else
  {
    //丢弃
    await showToast("玩家丢弃物品“装置”，增加3枚骰子");
    for(int i=0;i<blackhouseGame.persons[blackhouseGame.itemsmap[7].ownerid].itemlist.length;i++)
    {
      if(blackhouseGame.persons[blackhouseGame.itemsmap[7].ownerid].itemlist[i]==7){
        blackhouseGame.persons[blackhouseGame.itemsmap[7].ownerid].itemlist.removeAt(i);
        break;
      }
    }
    blackhouseGame.itemsmap[7].ownerid = 0;
    blackhouseGame.itemsmap[7].choosemapid = 0;
    return 3;
  }
}

//8魔像
Future items08(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“魔像”");
  await showItemCard(8,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(8);
  blackhouseGame.itemsmap[8].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[8].choosemapid=mapid;
  blackhouseGame.itemsmap[8].isopen=true;
}

//魔像效果1： 为所有考验增加一枚骰子
Future<int> items08_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  await showToast("持有[魔像]，考验掷骰子增加1枚骰子");
    return 1;
}

//魔像效果2： 丢弃或失去魔像
Future<int> items08_effect02(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  await showToast("丢失[魔像]，玩家所有属性下降1级");
  if(blackhouseGame.persons[blackhouseGame.itemsmap[8].ownerid].currentmight>1)
  blackhouseGame.persons[blackhouseGame.itemsmap[8].ownerid].currentmight -= 1;
  if(blackhouseGame.persons[blackhouseGame.itemsmap[8].ownerid].currentspeed>1)
    blackhouseGame.persons[blackhouseGame.itemsmap[8].ownerid].currentspeed-= 1;
  if(blackhouseGame.persons[blackhouseGame.itemsmap[8].ownerid].currentsanity>1)
    blackhouseGame.persons[blackhouseGame.itemsmap[8].ownerid].currentsanity-= 1;
  if(blackhouseGame.persons[blackhouseGame.itemsmap[8].ownerid].currentknowledge>1)
    blackhouseGame.persons[blackhouseGame.itemsmap[8].ownerid].currentknowledge -= 1;
  for(int i=0;i<blackhouseGame.persons[blackhouseGame.itemsmap[8].ownerid].itemlist.length;i++)
  {
    if(blackhouseGame.persons[blackhouseGame.itemsmap[8].ownerid].itemlist[i]==8){
      blackhouseGame.persons[blackhouseGame.itemsmap[8].ownerid].itemlist.removeAt(i);
      break;
    }
  }
  blackhouseGame.itemsmap[8].ownerid = 0;
  blackhouseGame.itemsmap[8].choosemapid = 0;
  return 0;
}


//9吊坠盒
Future items09(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“吊坠盒”");
  await showItemCard(9,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(9);
  blackhouseGame.itemsmap[9].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[9].choosemapid=mapid;
  blackhouseGame.itemsmap[9].isopen=true;

  //持有者神志增加1
  blackhouseGame.persons[blackhouseGame.itemsmap[9].ownerid].currentsanity+= 1;
}

//吊坠盒效果1：任何时间受到精神伤害减1
Future<int> items09_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  await showToast("玩家持有[吊坠盒]，精神伤害减1");
  return -1;
}

//吊坠盒效果2：失去降低1神志
Future<int> items09_effect02(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  await showToast("失去[吊坠盒]，玩家神志属性下降1级");

  if(blackhouseGame.persons[blackhouseGame.itemsmap[9].ownerid].currentsanity>1)
    blackhouseGame.persons[blackhouseGame.itemsmap[9].ownerid].currentsanity-= 1;
  for(int i=0;i<blackhouseGame.persons[blackhouseGame.itemsmap[9].ownerid].itemlist.length;i++)
  {
    if(blackhouseGame.persons[blackhouseGame.itemsmap[9].ownerid].itemlist[i]==9){
      blackhouseGame.persons[blackhouseGame.itemsmap[9].ownerid].itemlist.removeAt(i);
      break;
    }
  }
  blackhouseGame.itemsmap[9].ownerid = 0;
  blackhouseGame.itemsmap[9].choosemapid = 0;
  return 0;
}


//10蛇油
Future items10(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“蛇油”");
  await showItemCard(10,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(10);
  blackhouseGame.itemsmap[10].ownerid=blackhouseGame.currentplayer;
}


//蛇油效果：弃掉此卡牌，选择一名玩家的任意属性提升到初始值
Future<int> items10_effect01(BuildContext context,BlackHouseGame blackhouseGame)  async{
  String isusefuction=await ifuseCard(context,"蛇油","是否使用蛇油对任意玩家任意属性进行初始化");
  if(isusefuction=="cancel") return -1;
  else
  {
    List<int> playerlist=[];
    for(int i=1;i<=blackhouseGame.playernum;i++)
    {
        playerlist.add(i);
    }

    var result = await showDialog(
        barrierDismissible:false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('请选择要改变属性的玩家'),
            actions: <Widget>[
              ChooseNum(3,playerlist,blackhouseGame),
              FlatButton(
                child: Text('确认'),
                onPressed: () {
                  if(chooseNum==-1)
                    showToast("还未选择玩家，请选择玩家");
                  else {
                    showToast("已选择玩家${blackhouseGame.persons[chooseNum].playername}");
                    Navigator.of(context).pop(chooseNum);
                  }
                },
              ),
            ],
          );
        });

    int chooseplayer=chooseNum;

    List<int> shuxing=[0,1,2,3];
    result = await showDialog(
        barrierDismissible:false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('请选择要的属性'),
            actions: <Widget>[
              ChooseNum(4,shuxing,blackhouseGame),
              FlatButton(
                child: Text('确认'),
                onPressed: () {
                  if(chooseNum==-1)
                    showToast("还未选择属性，请选择属性");
                  else {
                    showToast("已选择属性${shuxinglist[chooseNum]}");
                    Navigator.of(context).pop(chooseNum);
                  }
                },
              ),
            ],
          );
        });
    showToast("使用[蛇油]，将玩家${blackhouseGame.persons[chooseplayer].playername}的[${shuxinglist[chooseNum]}]属性恢复初始化");
    if(chooseNum==0)
      blackhouseGame.persons[chooseplayer].currentmight=blackhouseGame.persons[chooseplayer].initmight;
    else if(chooseNum==1)
      blackhouseGame.persons[chooseplayer].currentspeed=blackhouseGame.persons[chooseplayer].initspeed;
    else if(chooseNum==2)
      blackhouseGame.persons[chooseplayer].currentsanity=blackhouseGame.persons[chooseplayer].initsanity;
    else if(chooseNum==3)
      blackhouseGame.persons[chooseplayer].currentknowledge=blackhouseGame.persons[chooseplayer].initknowledge;

    showToast("玩家${blackhouseGame.persons[blackhouseGame.itemsmap[10].ownerid].playername}失去物品[蛇油]");
    for(int i=0;i<blackhouseGame.persons[blackhouseGame.itemsmap[10].ownerid].itemlist.length;i++)
    {
      if(blackhouseGame.persons[blackhouseGame.itemsmap[10].ownerid].itemlist[i]==10){
        blackhouseGame.persons[blackhouseGame.itemsmap[10].ownerid].itemlist.removeAt(i);
        break;
      }
    }
    blackhouseGame.itemsmap[10].ownerid = 0;
    blackhouseGame.itemsmap[10].choosemapid = 0;
    return result;
  }
}

//11茶壶
Future items11(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“茶壶”");
  await showItemCard(11,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(11);
  blackhouseGame.itemsmap[11].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[11].choosemapid = mapid;
  blackhouseGame.itemsmap[11].isopen = true;
}

//茶壶效果1： 如果是奸徒，放回卡堆
Future<int> items11_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  await showToast("你变成奸徒，失去[茶壶]，物品放入牌堆");
  for(int i=0;i<blackhouseGame.persons[blackhouseGame.itemsmap[11].ownerid].itemlist.length;i++)
  {
    if(blackhouseGame.persons[blackhouseGame.itemsmap[11].ownerid].itemlist[i]==11){
      blackhouseGame.persons[blackhouseGame.itemsmap[11].ownerid].itemlist.removeAt(i);
      break;
    }
  }
  blackhouseGame.itemsmap[11].ownerid = 0;
  blackhouseGame.itemsmap[11].choosemapid = 0;
  blackhouseGame.itemsmap[11].isopen = false;
  return 0;
}

//茶壶效果2：你房间有玩家受到伤害，抽取1张物品卡
Future<int> items11_effect02(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  String isusefuction=await ifuseCard(context,"茶壶","有玩家在你的房间受到伤害，是否抽取物品卡");
  if(isusefuction=="cancel") return -1;
  else
  {
    await showToast("你正在抽取一张物品卡"); //完善抽取物品卡函数
    await ItemEmit.triggerTheItem(context, blackhouseGame);
  }
}


//12肾上腺素
Future items12(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“肾上腺素”");
  await showItemCard(12,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(12);
  blackhouseGame.itemsmap[12].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[12].choosemapid = mapid;
  blackhouseGame.itemsmap[12].isopen = true;
}

//肾上腺素效果：检定前，可以为检定结果加4
Future<int> items12_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  String isusefuction=await ifuseCard(context,"肾上腺素","是否丢弃物品为检定结果加4");
  if(isusefuction=="cancel") return 0;
  else
  {
    //使用
    await showToast("玩家使用物品“肾上腺素”，检定结果将增加4点");
    abandonItem(blackhouseGame,12);
    return 4;
  }
}

//13上古护符
Future items13(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“上古护符”");
  await showItemCard(13,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(13);
  blackhouseGame.itemsmap[13].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[13].choosemapid = mapid;
  blackhouseGame.itemsmap[13].isopen = true;
  await showToast("玩家所有属性上升1级");
    blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentmight += 1;
    blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentspeed += 1;
    blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentsanity+= 1;
    blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentknowledge += 1;
}

//上古护符效果：失去所有属性降3级
Future<int> items13_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
await showToast("失去[上古神符]玩家所有属性下降3级");
if(blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentmight>3)
blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentmight -= 3;
else
  blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentmight = 1;

if(blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentspeed>3)
blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentspeed-= 3;
else
  blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentspeed= 1;

if(blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentsanity>3)
blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentsanity-= 3;
else
  blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentsanity= 1;

if(blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentknowledge>3)
blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentknowledge -= 3;
else
  blackhouseGame.persons[blackhouseGame.itemsmap[13].ownerid].currentknowledge = 1;

}

//14天使羽毛
Future items14(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“天使羽毛”");
  await showItemCard(14,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(14);
  blackhouseGame.itemsmap[14].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[14].choosemapid = mapid;
  blackhouseGame.itemsmap[14].isopen = true;
}

//天使羽毛效果：任何检定投掷时，选择0-8的点数代替
Future<int> items14_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  String isusefuction=await ifuseCard(context,"天使羽毛","是否丢弃此物品指定掷骰子的结果(0~8)");
  if(isusefuction=="cancel") return -1;
  else
  {
    List<int> values=[];
    for (int i = 0; i <= 8; i++) {
      values.add(i);
    }
    var result = await showDialog(
        barrierDismissible:false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('请指定想要的骰子点数'),
            actions: <Widget>[
              ChooseNum(1,values,blackhouseGame),
              FlatButton(
                child: Text('确认'),
                onPressed: () {
                  if(chooseNum==-1)
                    showToast("还未选择骰子点数，请选择点数");
                  else {
                    showToast("已选择点数$chooseNum为掷骰子结果");
                    Navigator.of(context).pop(chooseNum);
                  }
                },
              ),
            ],
          );
        });
    await showToast("玩家使用物品“天使羽毛”，指定检定结果为${chooseNum}");
    abandonItem(blackhouseGame,14);
    return result;
  }
}


//15盔甲
Future items15(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“盔甲”");
  await showItemCard(15,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(15);
  blackhouseGame.itemsmap[15].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[15].choosemapid = mapid;
  blackhouseGame.itemsmap[15].isopen = true;
  blackhouseGame.itemsmap[15].isstolen=false;
}

//盔甲效果
Future<int> items15_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  await showToast("发动[盔甲]效果，减少一点物理伤害");
  return 1;
}



//16斧头
Future items16(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“斧头”");
  await showItemCard(16,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(16);
  blackhouseGame.itemsmap[16].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[16].choosemapid = mapid;
  blackhouseGame.itemsmap[16].isopen = true;
  blackhouseGame.itemsmap[16].iswepon=true;

}
//斧头效果
Future<int> items16_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  String isusefuction=await ifuseCard(context,"斧头","是否发动斧头效果，多掷1个骰子？");
  if(isusefuction=="cancel") return -1;
  else
  {
    await showToast("发动[斧头]效果，增加一个骰子");
    return 1;
  }
}

//17铃铛
Future items17(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“铃铛”");
  await showItemCard(17,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(17);
  blackhouseGame.itemsmap[17].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[17].choosemapid=mapid;
  blackhouseGame.itemsmap[17].isopen=true;

  //持有者神志增加1
  blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].currentsanity+= 1;
  //如果同时有蜡烛、铃铛、书，增加2点全属性
  if(blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.contains(20)
      &&blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.contains(17)
      &&blackhouseGame.persons[blackhouseGame.currentplayer].omenlist.contains(2))
  {
    await showToast("拥有烛、书和铃铛，增加2点全属性");
    blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentmight += 2;
    blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentspeed += 2;
    blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentsanity += 2;
    blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentknowledge += 2;
  }
}

//铃铛效果1：失去降低1神志
Future<int> items17_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  await showToast("失去[铃铛]，玩家神志属性下降1级");
  if(blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].currentsanity>1)
    blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].currentsanity-= 1;
  //如果同时有蜡烛、铃铛、书，丢失蜡烛，减少2点全属性
  if(blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.contains(20)
      &&blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.contains(17)
      &&blackhouseGame.persons[blackhouseGame.currentplayer].omenlist.contains(2))
  {
    await showToast("丢失铃铛，减少2点全属性");
    blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].currentmight -= 2;
    blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].currentspeed -= 2;
    blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].currentsanity -= 2;
    blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].currentknowledge -= 2;
  }
  abandonItem(blackhouseGame, 1720);
  return 0;
}

//铃铛效果2：每回合可以用铃铛进行一次神志掷骰 ,后续添加路径功能
Future<int> items17_effect02(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  await showToast("失去[铃铛]，玩家神志属性下降1级");

  if(blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].currentsanity>1)
    blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].currentsanity-= 1;
  for(int i=0;i<blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].itemlist.length;i++)
  {
    if(blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].itemlist[i]==17){
      blackhouseGame.persons[blackhouseGame.itemsmap[17].ownerid].itemlist.removeAt(i);
      break;
    }
  }
  blackhouseGame.itemsmap[17].ownerid = 0;
  blackhouseGame.itemsmap[17].choosemapid = 0;
  return 0;
}

//18血棘
Future items18(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“血棘”");
  await showItemCard(18,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(18);
  blackhouseGame.itemsmap[18].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[18].choosemapid=mapid;
  blackhouseGame.itemsmap[18].isopen=true;
  blackhouseGame.itemsmap[18].iswepon=true;
}

//血棘效果1：力量攻击可以多掷骰子3颗，损失一点速度
Future<int> items18_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async {
  if(blackhouseGame.persons[blackhouseGame.itemsmap[18].ownerid].currentmight>1)
  {
  String isusefuction = await ifuseCard(context, "血棘", "是否使用血棘为力量攻击掷骰子增加3枚骰子(损失1点速度)");
  if (isusefuction == "cancel")
    return 0;
  else {
    blackhouseGame.persons[blackhouseGame.itemsmap[18].ownerid].currentmight -=1;
    return 3;
  }
  }
}

//血棘效果2：如果被偷窃，受到2骰子物理伤害
Future<int> items18_effect02(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async {
  await showToast("“血棘”被偷窃，玩家${blackhouseGame.persons[blackhouseGame.itemsmap[18].ownerid].playername}需要受到2骰子物理伤害，正在掷骰子");
  await BodyDamageByDiceNum(context, 2, blackhouseGame, blackhouseGame.itemsmap[18].ownerid);
  abandonItem(blackhouseGame, 18);
}


//19瓶子
Future items19(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“瓶子”");
  await showItemCard(19,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(19);
  blackhouseGame.itemsmap[19].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[19].choosemapid=mapid;
  blackhouseGame.itemsmap[19].isopen=true;
}

//瓶子效果：真相被揭露后
Future<int> items19_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async {
    String isusefuction = await ifuseCard(context, "瓶子", "是否投掷3个骰子，喝一口瓶子里的液体");
    if (isusefuction == "cancel")
      return 0;
    else {
      await showToast("玩家${blackhouseGame.persons[blackhouseGame.itemsmap[18].ownerid].playername}，正在掷骰子");
      int playerTotalDice = await rollTheDice(blackhouseGame,3);
      switch(playerTotalDice){
        case 6:
          print("选择一个房间将你的人物移动过去");
          //用小地图的界面
          break;
        case 5:
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentmight+= 2;
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentspeed+= 2;
          await showToast("增加2级力量和2级速度");
          break;
        case 4:
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentsanity+= 2;
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentknowledge+= 2;
          await showToast("增加2级知识和2级神志");
          break;
        case 3:
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentmight -= 1;
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentknowledge+= 1;
          await showToast("增加1级知识,减少1级力量");
          break;
        case 2:
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentsanity -= 2;
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentknowledge -= 2;
          await showToast("减少2级知识和2级神志");
          break;
        case 1:
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentmight -= 2;
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentspeed -= 2;
          await showToast("减少2级力量和2级速度");
          break;
        case 0:
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentmight -= 2;
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentspeed -= 2;
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentsanity -= 2;
          blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentknowledge -= 2;
          await showToast("减少2级全属性");
          break;
      }

      abandonItem(blackhouseGame, 19);
    }
}

//20蜡烛
Future items20(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“蜡烛”");
  await showItemCard(20,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(20);
  blackhouseGame.itemsmap[20].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[20].choosemapid=mapid;
  blackhouseGame.itemsmap[20].isopen=true;

  //如果同时有蜡烛、铃铛、书，增加2点全属性
  if(blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.contains(20)
  &&blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.contains(17)
  &&blackhouseGame.persons[blackhouseGame.currentplayer].omenlist.contains(2))
    {
      await showToast("拥有烛、书和铃铛，增加2点全属性");
      blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentmight += 2;
      blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentspeed += 2;
      blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentsanity += 2;
      blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentknowledge += 2;
    }
}

//蜡烛效果1：抽事件卡时如果有检定，增加一个骰子
Future<int> items20_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  await showToast("为事件检定增加一个骰子");
  return 1;
}

//蜡烛效果2：如果有蜡烛、书和铃铛，失去一样减少2点全属性
Future<int> items20_effect02(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async{
  //如果同时有蜡烛、铃铛、书，丢失蜡烛，减少2点全属性
  if(blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.contains(20)
      &&blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.contains(17)
      &&blackhouseGame.persons[blackhouseGame.currentplayer].omenlist.contains(2))
  {
    await showToast("丢失蜡烛，减少2点全属性");
    blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentmight -= 2;
    blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentspeed -= 2;
    blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentsanity -= 2;
    blackhouseGame.persons[blackhouseGame.itemsmap[20].ownerid].currentknowledge -= 2;
  }
  abandonItem(blackhouseGame, 20);
  return 1;
}



//21黑暗骰子
Future items21(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“黑暗骰子”");
  await showItemCard(21,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(21);
  blackhouseGame.itemsmap[21].ownerid=blackhouseGame.currentplayer;
  blackhouseGame.itemsmap[21].choosemapid=mapid;
  blackhouseGame.itemsmap[21].isopen=true;
}
//黑暗骰子效果：待完善
Future<int> items21_effect01(BuildContext context,int diceNum,BlackHouseGame blackhouseGame)  async {
  String isusefuction = await ifuseCard(context, "黑暗骰子", "是否投掷3个骰子进行判定");
  if (isusefuction == "cancel")
    return 0;
  else {
    await showToast("玩家${blackhouseGame.persons[blackhouseGame.itemsmap[18].ownerid].playername}，正在掷骰子");
    int playerTotalDice = await rollTheDice(blackhouseGame,3);
    switch(playerTotalDice){
      case 6:
        print("移动到任意一个未被确定为奸徒的探险者房间");
        //用小地图的界面
        break;
      case 5:
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentmight+= 2;
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentspeed+= 2;
        await showToast("增加2级力量和2级速度");
        break;
      case 4:
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentsanity+= 2;
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentknowledge+= 2;
        await showToast("增加2级知识和2级神志");
        break;
      case 3:
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentmight -= 1;
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentknowledge+= 1;
        await showToast("增加1级知识,减少1级力量");
        break;
      case 2:
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentsanity -= 2;
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentknowledge -= 2;
        await showToast("减少2级知识和2级神志");
        break;
      case 1:
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentmight -= 2;
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentspeed -= 2;
        await showToast("减少2级力量和2级速度");
        break;
      case 0:
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentmight -= 2;
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentspeed -= 2;
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentsanity -= 2;
        blackhouseGame.persons[blackhouseGame.itemsmap[19].ownerid].currentknowledge -= 2;
        await showToast("减少2级全属性");
        break;
    }

    abandonItem(blackhouseGame, 19);
  }
}


//22炸药
Future items22(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“炸药”");
  await showItemCard(22,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(22);
  blackhouseGame.itemsmap[22].ownerid=blackhouseGame.currentplayer;
}
//炸药效果


//23治疗膏药
Future items23(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“治疗膏药”");
  await showItemCard(23,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(23);
  blackhouseGame.itemsmap[23].ownerid=blackhouseGame.currentplayer;
}


//24神像
Future items24(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“神像”");
  await showItemCard(24,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(24);
  blackhouseGame.itemsmap[24].ownerid=blackhouseGame.currentplayer;
}


//25幸运石
Future items25(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“幸运石”");
  await showItemCard(25,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(25);
  blackhouseGame.itemsmap[25].ownerid=blackhouseGame.currentplayer;
}


//26医疗包
Future items26(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“医疗包”");
  await showItemCard(26,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(26);
  blackhouseGame.itemsmap[26].ownerid=blackhouseGame.currentplayer;
}


//27音乐盒
Future items27(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“音乐盒”");
  await showItemCard(27,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(27);
  blackhouseGame.itemsmap[27].ownerid=blackhouseGame.currentplayer;
}


//28盗贼手套
Future items28(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“盗贼手套”");
  await showItemCard(28,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(28);
  blackhouseGame.itemsmap[28].ownerid=blackhouseGame.currentplayer;
}
//29解密方块
Future items29(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“解密方块”");
  await showItemCard(29,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(29);
  blackhouseGame.itemsmap[29].ownerid=blackhouseGame.currentplayer;
}
//30兔脚
Future items30(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“兔脚”");
  await showItemCard(30,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(30);
  blackhouseGame.itemsmap[30].ownerid=blackhouseGame.currentplayer;
}
//31左轮手枪
Future items31(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“左轮手枪”");
  await showItemCard(31,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(31);
  blackhouseGame.itemsmap[31].ownerid=blackhouseGame.currentplayer;

}
//32献祭之刃
Future items32(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“献祭之刃”");
  await showItemCard(32,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(32);
  blackhouseGame.itemsmap[32].ownerid=blackhouseGame.currentplayer;
}
//33嗅盐
Future items33(BlackHouseGame blackhouseGame,BuildContext context) async{
  String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
  int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
  String mapname=blackhouseGame.maps[mapid].roomname;
  int playerID=blackhouseGame.currentplayer;
  await showToast("玩家${currentplayername}在房间${mapname}找到了物品“嗅盐”");
  await showItemCard(33,blackhouseGame);
  blackhouseGame.persons[blackhouseGame.currentplayer].itemlist.add(33);
  blackhouseGame.itemsmap[33].ownerid=blackhouseGame.currentplayer;
}

void abandonItem(BlackHouseGame blackhouseGame,int itemID){
  for(int i=0;i<blackhouseGame.persons[blackhouseGame.itemsmap[itemID].ownerid].itemlist.length;i++)
  {
    if(blackhouseGame.persons[blackhouseGame.itemsmap[itemID].ownerid].itemlist[i]==itemID){
      blackhouseGame.persons[blackhouseGame.itemsmap[itemID].ownerid].itemlist.removeAt(i);
      break;
    }
  }
  blackhouseGame.itemsmap[itemID].ownerid = 0;
  blackhouseGame.itemsmap[itemID].choosemapid = 0;
}
