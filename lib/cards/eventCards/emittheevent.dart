//触发事件函数
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:flutter/material.dart';
import 'eventsfuction.dart';
import 'package:blackhouse/tools/cardstools.dart';
import 'dart:math';
import 'package:blackhouse/config/param.dart';

  //首次进入房间，先触发卡牌事件，再触发房间事件
  //卡片的触发事件
  Future triggerTheEvent(BuildContext context,BlackHouseGame blackhouseGame)
  async{
    //判断是否还有牌未打开
    List<int> cardidlist=new List();
    for(int i=1;i<=56;i++)
    {
        if(!blackhouseGame.eventsmap[i].isopen) {
          cardidlist.add(i);
        }
    }

    if(cardidlist.length==0)
    {
        await showToast("事件卡牌抽完了");
        return ;
    }

    var dicerandom = new Random();
    int num = dicerandom.nextInt(cardidlist.length);

    int cardid=cardidlist[num];
    eventcardId=cardid;
    blackhouseGame.eventsmap[cardid].isopen=true;
    switch(cardid) {
      case 1:
        await piankexiwang(blackhouseGame,context);        //片刻希望
        break;
      case 2:
        await angrylife(blackhouseGame,context);          //愤怒生物
        break;
      case 3:
        await bloodyfantasy(blackhouseGame,context);          //血腥幻想
        break;
      case 4:
        await peopleOnFire(blackhouseGame,context);          //着火的人
        break;
      case 5:
        await theClosetDoor(blackhouseGame,context);          //壁橱的门
        break;
      case 6:
        await horrorReptiles(blackhouseGame,context);          //惊悚爬虫
        break;
      case 7:
        await horrorDoll(blackhouseGame,context);          //恐怖玩偶
        break;
      case 8:
        await rubble(blackhouseGame,context);          //瓦砾
        break;
      case 9:
        await uneasySound(blackhouseGame,context);          //不安的响声
        break;
      case 10:
        await tickTickTick(blackhouseGame,context);          //滴答滴答滴答
        break;
      case 11:
        await footprint(blackhouseGame,context);          //脚印
        break;
      case 12:
        await funeral(blackhouseGame,context);          //葬礼
        break;
      case 13:
        await graveSoil(blackhouseGame,context);          //坟土
        break;
      case 14:
        await gardener(blackhouseGame,context);          //园丁
        break;
      case 15:
        await theClosetDoor2(blackhouseGame,context);          //壁橱的门
        break;
      case 16:
        await frighteningScreams(blackhouseGame,context);          //骇人尖叫
        break;
      case 17:
        await imageInMirror(blackhouseGame,context);          //镜中影像
        break;
      case 18:
        await imageInMirror2(blackhouseGame,context);          //镜中影像2
        break;
      case 19:
        await destined(blackhouseGame,context);          //命中注定
        break;
      case 20:
        await turnToJonah(blackhouseGame,context);          //轮到约拿了
        break;
      case 21:
        await lightTurnDown(blackhouseGame,context);          //灯灭了
        break;
      case 22:
        await strongBox(blackhouseGame,context);          //保险箱
        break;
      case 23:
        await mistOnTheWall(blackhouseGame,context);          //墙上雾霭
        break;
      case 24:
        await mysteriousSlide(blackhouseGame,context);          //神秘滑梯
        break;
      case 25:
        await nightFantasy(blackhouseGame,context);          //暗夜幻想
        break;
      case 26:
        await telephoneRing(blackhouseGame,context);          //电话铃声
        break;
      case 27:
        await erode(blackhouseGame,context);          //侵蚀
        break;
      case 28:
        await revolvingWall(blackhouseGame,context);          //旋转墙
        break;
      case 29:
        await Putrefaction(blackhouseGame,context);          //腐烂
        break;
      case 30:
        await secretPassage(blackhouseGame,context);          //秘密通道
        break;
      case 31:
        await secretStaircase(blackhouseGame,context);          //秘密楼梯
        break;
      case 32:
        await HowlingWind(blackhouseGame,context);          //尖啸狂风
        break;
      case 33:
        await silent(blackhouseGame,context);          //寂静
        break;
      case 34:
        await humanBones(blackhouseGame,context);          //骸骨
        break;
      case 35:
        await smoke(blackhouseGame,context);          //烟雾
        break;
      case 36:
        await hiddenItems(blackhouseGame,context);          //隐藏物品
        break;
      case 37:
        await slimyStuff(blackhouseGame,context);          //黏滑的东西
        break;
      case 38:
        await spider(blackhouseGame,context);          //蜘蛛
        break;
      case 39:
        //await call(blackhouseGame,context);          //呼唤
        break;
      case 40:
        await lostPeople(blackhouseGame,context);          //迷失的人
        break;
      case 41:
        await sound(blackhouseGame,context);          //声音
        break;
      case 42:
        await wall(blackhouseGame,context);          //墙壁
        break;
      case 43:
        await cobweb(blackhouseGame,context);          //蛛网
        break;
      case 44:
        //await wheresThis(blackhouseGame,context);          //这是哪
        break;
      case 45:
        await aiya(blackhouseGame,context);          //哎呀！
        break;
      case 46:
        await acupuncture(blackhouseGame,context);          //针刺
        break;
      case 47:
        await grave(blackhouseGame,context);          //冢
        break;
      case 48:
        await contract(blackhouseGame,context);          //合约
        break;
      case 49:
        await dionaeaMuscipula(blackhouseGame,context);          //捕蝇草
        break;
      case 50:
        await goastInMachine(blackhouseGame,context);          //机器里的鬼魂
        break;
      case 51:
        await lightningStrike(blackhouseGame,context);          //雷击
        break;
      case 52:
        await fogArch(blackhouseGame,context);          //迷雾拱门
        break;
      case 53:
        await mutantPet(blackhouseGame,context);          //变异宠物
        break;
      case 54:
        await leftHand(blackhouseGame,context);          //左手
        break;
      case 55:
        //await eyesOnTheWall(blackhouseGame,context);          //墙上有眼
        break;
      case 56:
        await whichYear(blackhouseGame,context);          //今夕是何年
        break;
      defaut:
        break;
    }
  }

  //房间的触发事件,主要是事件所在的房间
  bool istriggerTheRoom(int mapid,BlackHouseGame blackhouseGame)
  {
    bool isTrigger=false;
    if(blackhouseGame.maps[mapid].eventflags>0)
      isTrigger=true;

    return isTrigger;
  }
