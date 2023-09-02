//触发物品函数
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:flutter/material.dart';
import 'itemsfuction.dart';
import 'package:blackhouse/tools/cardstools.dart';
import 'dart:math';

//首次进入房间，先触发卡牌事件，再触发房间事件
//卡片的触发事件
Future triggerTheItem(BuildContext context,BlackHouseGame blackhouseGame)
async{
  //判断是否还有牌未打开
  List<int> cardidlist=new List();
  for(int i=1;i<=33;i++)
  {
    if(!blackhouseGame.itemsmap[i].isopen) {
      cardidlist.add(i);
    }
  }

  if(cardidlist.length==0)
  {
    await showToast("物品卡牌抽完了");
    return;
  }

  var dicerandom = new Random();
  int num = dicerandom.nextInt(cardidlist.length);

  int cardid=cardidlist[num];

  blackhouseGame.itemsmap[cardid].isopen=true;
  switch(cardid) {
    case 1:
      await items01(blackhouseGame,context);
      break;
    case 2:
      await items02(blackhouseGame,context);
      break;
    case 3:
      await items03(blackhouseGame,context);
      break;
    case 4:
      await items04(blackhouseGame,context);
      break;
    case 5:
      await items05(blackhouseGame,context);
      break;
    case 6:
      await items06(blackhouseGame,context);
      break;
    case 7:
      await items07(blackhouseGame,context);
      break;
    case 8:
      await items08(blackhouseGame,context);
      break;
    case 9:
      await items09(blackhouseGame,context);
      break;
    case 10:
      await items10(blackhouseGame,context);
      break;
    case 11:
      await items11(blackhouseGame,context);
      break;
    case 12:
      await items12(blackhouseGame,context);
      break;
    case 13:
      await items13(blackhouseGame,context);
      break;
    case 14:
      await items14(blackhouseGame,context);
      break;
    case 15:
      await items15(blackhouseGame,context);
      break;
    case 16:
      await items16(blackhouseGame,context);
      break;
    case 17:
      await items17(blackhouseGame,context);
      break;
    case 18:
      await items18(blackhouseGame,context);
      break;
    case 19:
      await items19(blackhouseGame,context);
      break;
    case 20:
      await items20(blackhouseGame,context);
      break;
    case 21:
      await items21(blackhouseGame,context);
      break;
    case 22:
      await items22(blackhouseGame,context);
      break;
    case 23:
      await items23(blackhouseGame,context);
      break;
    case 24:
      await items24(blackhouseGame,context);
      break;
    case 25:
      await items25(blackhouseGame,context);
      break;
    case 26:
      await items26(blackhouseGame,context);
      break;
    case 27:
      await items27(blackhouseGame,context);
      break;
    case 28:
      await items28(blackhouseGame,context);
      break;
    case 29:
      await items29(blackhouseGame,context);
      break;
    case 30:
      await items30(blackhouseGame,context);
      break;
    case 31:
      await items31(blackhouseGame,context);
      break;
    case 32:
      await items32(blackhouseGame,context);
      break;
    case 33:
      await items33(blackhouseGame,context);
      break;
      defaut:
      break;
  }
}

//房间的触发事件,主要是事件所在的房间
bool istriggerTheRoom(int mapid,BlackHouseGame blackhouseGame)
{
  bool isTrigger=false;
  if(blackhouseGame.maps[mapid].itemflags>0)
    isTrigger=true;

  return isTrigger;
}
