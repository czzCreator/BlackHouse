//触发征兆函数
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:flutter/material.dart';
import 'omensfuction.dart';
import 'package:blackhouse/tools/cardstools.dart';
import 'dart:math';

//首次进入房间，先触发卡牌事件，再触发房间事件
//卡片的触发事件
Future triggerTheOmen(BuildContext context,BlackHouseGame blackhouseGame)
async{
  //判断是否还有牌未打开
  List<int> cardidlist=new List();
  for(int i=1;i<=21;i++)
  {
    if(!blackhouseGame.omensmap[i].isopen) {
      cardidlist.add(i);
    }
  }

  if(cardidlist.length==0)
  {
    await showToast("征兆卡牌抽完了");
    return;
  }

  var dicerandom = new Random();
  int num = dicerandom.nextInt(cardidlist.length);

  int cardid=cardidlist[num];

  blackhouseGame.omensmap[cardid].isopen=true;
  switch(cardid) {
    case 1:
      await omen01(blackhouseGame,context);
      break;
    case 2:
      await omen02(blackhouseGame,context);
      break;
    case 3:
      await omen03(blackhouseGame,context);
      break;
    case 4:
      await omen04(blackhouseGame,context);
      break;
    case 5:
      await omen05(blackhouseGame,context);
      break;
    case 6:
      await omen06(blackhouseGame,context);
      break;
    case 7:
      await omen07(blackhouseGame,context);
      break;
    case 8:
      await omen08(blackhouseGame,context);
      break;
    case 9:
      await omen09(blackhouseGame,context);
      break;
    case 10:
      await omen10(blackhouseGame,context);
      break;
    case 11:
      await omen11(blackhouseGame,context);
      break;
    case 12:
      await omen12(blackhouseGame,context);
      break;
    case 13:
      await omen13(blackhouseGame,context);
      break;
    case 14:
      await omen14(blackhouseGame,context);
      break;
    case 15:
      await omen15(blackhouseGame,context);
      break;
    case 16:
      await omen16(blackhouseGame,context);
      break;
    case 17:
      await omen17(blackhouseGame,context);
      break;
    case 18:
      await omen18(blackhouseGame,context);
      break;
    case 19:
      await omen19(blackhouseGame,context);
      break;
    case 20:
      await omen20(blackhouseGame,context);
      break;
    case 21:
      await omen21(blackhouseGame,context);
      break;
      break;
      defaut:
      break;
  }
}

//房间的触发事件,主要是事件所在的房间
bool istriggerTheRoom(int mapid,BlackHouseGame blackhouseGame)
{
  bool isTrigger=false;
  if(blackhouseGame.maps[mapid].omenflags>0)
    isTrigger=true;

  return isTrigger;
}
