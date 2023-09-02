//事件牌操作
import 'package:blackhouse/cards/eventCards/emittheevent.dart' as EventEmit;
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:blackhouse/maps/showLayers.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:blackhouse/tools/cardstools.dart';
import 'package:blackhouse/config/param.dart';
import 'package:blackhouse/cards/itemsCards/emittheitem.dart' as ItemEmit;
import 'package:blackhouse/cards/omensCards/emittheomen.dart' as OmensEmit;
//1片刻希望
Future piankexiwang(BlackHouseGame blackhouseGame,BuildContext context) async{
   //如果当前玩家的mapid上没有放置祝福标记，添加祝福标记类，并把祝福标记的currentmapid绑定到当前玩家的currentmapid上，
   //祝福标记和该房间一起展示，同时房间的掷骰子数目加1，玩家进入房间直接用这个房间的骰子数目进行判定
   //如果有，返回房间的骰子判定加1
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间[${mapname}]遭遇了事件“片刻希望”");

   await showEventCard(1,blackhouseGame);
   blackhouseGame.maps[mapid].zhufuflag =1;
   await showToast("玩家${currentplayername}在房间[${mapname}]放置祝福标记");

   if(blackhouseGame.maps[mapid].dicenum<8)
   blackhouseGame.maps[mapid].dicenum +=1;
   await showToast("每位玩家在房间内掷骰子时增加一枚骰子");

}

//2愤怒生物
Future  angrylife(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerId=blackhouseGame.currentplayer;
   int currentspeedstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed;
   int currentspeed=blackhouseGame.persons[blackhouseGame.currentplayer].speedlist[currentspeedstage];
   await showToast("玩家${currentplayername}在房间[${mapname}[遭遇了事件“愤怒的生物”");
   await showEventCard(2,blackhouseGame);
   await showToast("正在进行速度检定");
   currentspeed=await getDiceNum(context,blackhouseGame,playerId,currentspeed,0);
   if(currentspeed>=5) {
      await showToast("玩家${currentplayername}当前速度检定为${currentspeed}，速度提升1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed += 1;
    }
   else if(currentspeed>=2&&currentspeed<=4)
    {
         await showToast("玩家${currentplayername}当前速度检定为${currentspeed},需要受到1骰子精神伤害，正在掷骰子");
         await MantalDamageByDiceNum(context,1,blackhouseGame,playerId);
    }
   else if(currentspeed>=0&&currentspeed<=1)
    {
      await showToast("玩家${currentplayername}当前速度检定为${currentspeed},需要受到1骰子精神伤害和一骰子力量伤害，正在掷骰子");
      await MantalDamageByDiceNum(context,1,blackhouseGame,playerId);
      await BodyDamageByDiceNum(context,1,blackhouseGame,playerId);
    }
}

//3血腥幻想
Future bloodyfantasy(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“血腥幻想”");
   await showEventCard(3,blackhouseGame);
   await showToast("正在进行神志检定");
   currentsanity=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentsanity,0);

   if(currentsanity>=4) {
      await showToast("玩家${currentplayername}神志检定为${currentsanity}，神志提升1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity += 1;
   }
   else if(currentsanity>=2&&currentsanity<=3)
   {
      await showToast("玩家${currentplayername}神志检定为${currentsanity},神志降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -= 1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity=1;
   }
   else if(currentsanity>=0&&currentsanity<=1)
   {
      List<int> playernearbylist=[];
      List<int> roomnearbylist=[];
      //先搜寻上下左右相连的房间
      roomnearbylist.add(mapid);
      if(blackhouseGame.maps[mapid].thedownroom!=0&&blackhouseGame.maps[mapid].downdoor!=0)
      {
          roomnearbylist.add(blackhouseGame.maps[mapid].thedownroom);
      }
      if(blackhouseGame.maps[mapid].theuproom!=0&&blackhouseGame.maps[mapid].updoor!=0)
      {
         roomnearbylist.add(blackhouseGame.maps[mapid].theuproom);
      }
      if(blackhouseGame.maps[mapid].theleftroom!=0&&blackhouseGame.maps[mapid].leftdoor!=0)
      {
         roomnearbylist.add(blackhouseGame.maps[mapid].theleftroom);
      }
      if(blackhouseGame.maps[mapid].therightroom!=0&&blackhouseGame.maps[mapid].rightdoor!=0)
      {
         roomnearbylist.add(blackhouseGame.maps[mapid].therightroom);
      }

      //搜寻哪些人在这些相邻房间
      for(int i=1 ;i<=blackhouseGame.playernum;i++)
      {
         if(i!=blackhouseGame.currentplayer) {
            //如果这些人所在房间在当前玩家旁边或者同一间，则存起来
            if(roomnearbylist.contains(blackhouseGame.persons[i].currentmapid))
            playernearbylist.add(i);
         }
      }

      //由玩家选择要攻击的对象，要做个弹窗
      await showToast("请选择要攻击的对象");
      int fightplayer=2;
      int fighter1=blackhouseGame.persons[blackhouseGame.currentplayer].mightlist[blackhouseGame.persons[blackhouseGame.currentplayer].currentmight];
      int fighter2=blackhouseGame.persons[fightplayer].mightlist[blackhouseGame.persons[fightplayer].currentmight];
      //袭击
      await fight(blackhouseGame,blackhouseGame.currentplayer,fightplayer,
          fighter1,fighter2);
   }
}

//4着火的人
Future peopleOnFire(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerId=blackhouseGame.currentplayer;

   int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“着火的人”");
   await showEventCard(4,blackhouseGame);
   await showToast("正在进行神志检定");
   currentsanity=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentsanity,0);

   if(currentsanity>=4) {
      await showToast("玩家${currentplayername}神志检定为${currentsanity}，神志提升1级");
//      modify by gaoyang 2021-1-14
//      blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed += 1;
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity += 1;
   }
   else if(currentsanity>=2&&currentsanity<=3)
   {
      await showToast("玩家${currentplayername}神志检定为${currentsanity}，移动到了入口大厅");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=3;
      blackhouseGame.currentleftmap = blackhouseGame.maps[1];
      blackhouseGame.currentmiddlemap = blackhouseGame.maps[2];
      blackhouseGame.currentrightmap = blackhouseGame.maps[3];
   }
   else if(currentsanity>=0&&currentsanity<=1)
   {
      await showToast("玩家${currentplayername}神志检定为${currentsanity},身上爆发火焰，需要受到一骰子肉体伤害，正在掷骰子");
      await BodyDamageByDiceNum(context,1,blackhouseGame,playerId);
      await showToast("拍灭火焰时受到1骰子精神伤害");
      await MantalDamageByDiceNum(context,1,blackhouseGame,playerId);
}
}

//5壁橱的门
Future theClosetDoor(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“壁橱的门”");
   await showEventCard(5,blackhouseGame);
   blackhouseGame.maps[mapid].bichuflag =1;
   await showToast("玩家${currentplayername}在房间${mapname}放置壁橱标记");
   int playerTotalDice=0;
   await showToast("玩家${currentplayername}进行掷2颗骰子开启壁橱判定");

   playerTotalDice=await rollTheDice(blackhouseGame,2);

   await showToast("玩家${currentplayername}总骰子数为${playerTotalDice}");

   if(playerTotalDice==4)
      {
         await showToast("抽取两张物品卡");   //完善抽取物品卡函数，调用两次
         await ItemEmit.triggerTheItem(context,blackhouseGame);
         await ItemEmit.triggerTheItem(context,blackhouseGame);
      }
   else if(playerTotalDice>=2&&playerTotalDice<=3)
      {
         await showToast("抽取一张事件卡");  //完善抽取事件卡函数，调用一次
         await EventEmit.triggerTheEvent(context, blackhouseGame);
      }
   else {
      await showToast("抽取一张事件卡");
      blackhouseGame.maps[mapid].bichuflag =0;  //移除壁橱标志
      await EventEmit.triggerTheEvent(context, blackhouseGame);
   }
}

//6惊悚爬虫
Future horrorReptiles(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“惊悚爬虫”");
   await showEventCard(6,blackhouseGame);
   await showToast("正在进行神志检定");
   currentsanity=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentsanity,0);

   if(currentsanity>=5) {
      await showToast("玩家${currentplayername}神志检定为${currentsanity}，神志提升1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity += 1;
   }
   else if(currentsanity>=1&&currentsanity<=4) {
      await showToast("玩家${currentplayername}神志检定为${currentsanity}，神志降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -= 1;
   }
   //卡牌有bug,神志为0时没法再降低，应该是精神伤害，需要添加力量和精神伤害分配的弹窗
   if(currentsanity==0) {
      await showToast("玩家${currentplayername}神志检定为${currentsanity}，知识为${blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge},知识降低2级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge-= 2;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge=1;
   }
}

//7恐怖玩偶
Future horrorDoll(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“恐怖玩偶”");
   await showEventCard(7,blackhouseGame);
   int currentplayer=blackhouseGame.currentplayer;
   int rightplayer=0;
   if(blackhouseGame.currentplayer==blackhouseGame.playernum)
      rightplayer=1;
   else rightplayer=currentplayer+1;
   await showToast("玩家${blackhouseGame.persons[rightplayer].playername}代替玩偶(4点力量)对玩家${blackhouseGame.persons[currentplayer].playername}发动了袭击");
   int mightnow=blackhouseGame.persons[currentplayer].currentmight;
   int fighter1minght=blackhouseGame.persons[currentplayer].mightlist[mightnow];
   await fight(blackhouseGame,currentplayer,rightplayer, fighter1minght,4);
   //受到伤害
   if(blackhouseGame.persons[currentplayer].currentmight<mightnow)
      {
         //拥有长矛的非当前玩家提升两级力量
         if(blackhouseGame.omensmap[12].ownerid!=currentplayer&&blackhouseGame.omensmap[12].ownerid!=0)
            {
               await showToast("拥有长矛的玩家${blackhouseGame.persons[blackhouseGame.omensmap[12].ownerid].playername}提升两点力量");
            blackhouseGame.persons[blackhouseGame.omensmap[12].ownerid].currentmight =blackhouseGame.persons[blackhouseGame.omensmap[12].ownerid].currentmight+2;
            }
      }
}


//8瓦砾
Future rubble(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerId=blackhouseGame.currentplayer;
   int currentspeedstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed;
   int currentspeed=blackhouseGame.persons[blackhouseGame.currentplayer].speedlist[currentspeedstage];
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“瓦砾”");
   await showEventCard(8,blackhouseGame);
   await showToast("正在进行速度检定");
   currentspeed=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentspeed,0);

   if(currentspeed>=3) {
      await showToast("玩家${currentplayername}速度检定为${currentspeed}，速度提升1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed += 1;
   }
   else if(currentspeed>=1&&currentspeed<=2)
   {
      await showToast("玩家${currentplayername}速度检定为${currentspeed},需要受到1骰子肉体伤害，正在掷骰子");
      await BodyDamageByDiceNum(context,1,blackhouseGame,playerId);
      await showToast("玩家${currentplayername}被压住了");
      //别的玩家回合要判断瓦砾
      blackhouseGame.eventsmap[8].ownerid=blackhouseGame.currentplayer;
      blackhouseGame.persons[blackhouseGame.currentplayer].walinum=3;  //为0的时候才能行动，别的玩家回合可以选择判断力量4+来救你
   }
   else if(currentspeed==0)
   {
      await showToast("玩家${currentplayername}速度检定为${currentspeed},需要受到2骰子肉体伤害，正在掷骰子");
      await BodyDamageByDiceNum(context,2,blackhouseGame,playerId);
   }
}

//9不安的响声
Future uneasySound(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“不安的响声”");
   await showEventCard(9,blackhouseGame);
   int eventsnum=0;
   for(int i=1;i<=blackhouseGame.eventsmap.length;i++)
      {
         if(blackhouseGame.eventsmap[i].isopen)
            eventsnum++;
      }
   await showToast("玩家${currentplayername}，正在掷骰子");
   int playerTotalDice=0;
   playerTotalDice=await rollTheDice(blackhouseGame,6);

   if(playerTotalDice>=eventsnum)
      {
         await showToast("玩家${currentplayername}内心感到轻松，提升一级神志");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity +=1;
      }
   else{
      await showToast("玩家${currentplayername}受到一骰子精神伤害");
      await MantalDamageByDiceNum(context,1,blackhouseGame,playerID);
   }
}

//10滴答滴答滴答
Future tickTickTick(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“滴答滴答滴答”");
   await showEventCard(10,blackhouseGame);
   blackhouseGame.maps[mapid].tickflag =1;
   await showToast("玩家${currentplayername}在房间${mapname}放置滴答标记");
   if(blackhouseGame.maps[mapid].dicenum>1)
      blackhouseGame.maps[mapid].dicenum -=1;
   await showToast("每位玩家在房间内掷骰子时减少一枚骰子");
}

//11脚印
Future footprint(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername = blackhouseGame.persons[blackhouseGame
       .currentplayer].playername;
   int mapid = blackhouseGame.persons[blackhouseGame.currentplayer]
       .currentmapid;
   String mapname = blackhouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“脚印”");
   await showEventCard(11,blackhouseGame);

   int dicenum = 1;
   if (mapid == 26) {
      await showToast("玩家处于礼拜堂，多一颗掷骰子");
      dicenum = 2;
   }
   await showToast("玩家${currentplayername}，正在掷骰子");

   int playerTotalDice = 0;
   playerTotalDice=await rollTheDice(blackhouseGame,dicenum);

   if (playerTotalDice == 4 || playerTotalDice == 3) {
      int mindistanceplayer = 0;
      double mindistance = 10000;
//找到最近的冒险者
      for (int i = 1; i <= blackhouseGame.playernum; i++) {
         if (i != blackhouseGame.currentplayer) {
            int tempmapid = blackhouseGame.persons[i].currentmapid;
            var dx = blackhouseGame.mapcoordinate[i].x -
                blackhouseGame.mapcoordinate[blackhouseGame.currentplayer].x;
            var dy = blackhouseGame.mapcoordinate[i].y -
                blackhouseGame.mapcoordinate[blackhouseGame.currentplayer].y;
            double distance = sqrt(dx * dx + dy * dy);
            if (distance <= mindistance) {
               mindistance = distance;
               mindistanceplayer = i;
            }
         }
      }

      //你和最近的冒险者提升一级力量
      if (playerTotalDice == 4) {
         await showToast("玩家${currentplayername}和玩家${blackhouseGame
             .persons[mindistanceplayer].playername}提升一级力量");
         blackhouseGame.persons[mindistanceplayer].currentmight += 1;
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmight += 1;
      }
      //你提升1级力量，最近的冒险者降低1级神志
      else if (playerTotalDice == 3) {
         await showToast("玩家${currentplayername}提升一级力量");
         await showToast("玩家${blackhouseGame.persons[mindistanceplayer].playername}降低1级神志");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmight += 1;
         blackhouseGame.persons[mindistanceplayer].currentsanity -= 1;
         if (blackhouseGame.persons[mindistanceplayer].currentsanity < 1)
            blackhouseGame.persons[mindistanceplayer].currentsanity = 1;
      }
   }
      else if (playerTotalDice == 2) {
      await showToast("玩家${currentplayername}降低1级神志");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -= 1;
         if (blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity < 1)
            blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity = 1;
      }
      else if (playerTotalDice == 1) {
      await showToast("玩家${currentplayername}降低1级速度");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed -= 1;
         if (blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed < 1)
            blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed = 1;
      }
      else {
      await showToast("每名玩家自己选择降低一点属性");
         //需要弹窗让玩家轮流选择
         for (int i = 1; i <= blackhouseGame.playernum; i++) {
            blackhouseGame.persons[i].currentspeed -= 1;
            if (blackhouseGame.persons[i].currentspeed < 1)
               blackhouseGame.persons[i].currentspeed = 1;
         }
      }
   }


//12葬礼
Future funeral(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“葬礼”");
   await showEventCard(12,blackhouseGame);

   await showToast("正在进行神志检定");
   currentsanity=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentsanity,0);

   if(currentsanity>=4) {
      await showToast("玩家${currentplayername}神志检定为${currentsanity}，神志提升1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity += 1;
   }
   else if(currentsanity>=2&&currentsanity<=3)
   {
      await showToast("玩家${currentplayername}神志检定为${currentsanity}，幻像让你感到困惑，神志降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -=1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity=1;
   }
   else if(currentsanity>=0&&currentsanity<=1)
   {
      await showToast("玩家${currentplayername}神志检定为${currentsanity},你真的躺在棺材中，受到1级力量伤害和1级神志伤害");

      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight-=1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentmight<0)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmight=0;

      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -=1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity=1;
      //玩家选择移往地下室或者墓园
      if(blackhouseGame.maps[35].isopen||blackhouseGame.maps[5].isopen)
         {
            blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=35;
         }
     }
}

//13坟土
Future graveSoil(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int currentmightstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentmight;
   int currentmight=blackhouseGame.persons[blackhouseGame.currentplayer].mightlist[currentmightstage];
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“坟土”");
   await showEventCard(13,blackhouseGame);

   await showToast("正在进行力量检定");
   currentmight=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentmight,0);

   if(currentmight>=4) {
      await showToast("玩家${currentplayername}力量为${currentmight}，力量提升1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight += 1;
   }
   else if(currentmight>=0&&currentmight<=3)
   {
      await showToast("玩家${currentplayername}神志为${currentmight}，幻像让你感到困惑，神志降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].eventslist.add(13);
      await showToast("玩家${currentplayername}获得卡牌“坟土");
   }
}

//14园丁
Future gardener(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“园丁”");
   await showEventCard(14,blackhouseGame);

   int currentknowledge=blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge;
   if(currentknowledge>=4)
      {
         await showToast("抽取物品卡"); //待实现
         await ItemEmit.triggerTheItem(context,blackhouseGame);
      }
   else
      {
   int currentplayer=blackhouseGame.currentplayer;
   int rightplayer=0;
   if(blackhouseGame.currentplayer==blackhouseGame.playernum)
      rightplayer=1;
   else rightplayer=currentplayer+1;
   await showToast("玩家${blackhouseGame.persons[rightplayer].playername}代替园丁(4点力量)对玩家${blackhouseGame.persons[currentplayer].playername}发动了袭击");

   int mightstagenow=blackhouseGame.persons[currentplayer].currentmight;
   int player1might=blackhouseGame.persons[currentplayer].mightlist[mightstagenow];
   //如果在花园则减少两颗骰子
   if(mapid==34)
   await fight(blackhouseGame,currentplayer,rightplayer,
       player1might-2,2);
   else
      await fight(blackhouseGame,currentplayer,rightplayer,
          player1might,4);
   }
}

//15壁橱的门
Future theClosetDoor2(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“壁橱的门”");
   await showEventCard(15,blackhouseGame);
   int currentknowledgestage=blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge;
   int currentknowledge=blackhouseGame.persons[blackhouseGame.currentplayer].knowledgelist[currentknowledgestage];
   int currentmightstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentmight;
   int currentmight=blackhouseGame.persons[blackhouseGame.currentplayer].mightlist[currentmightstage];
   int currentspeedstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed;
   int currentspeed=blackhouseGame.persons[blackhouseGame.currentplayer].speedlist[currentspeedstage];
   int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];

   bool allabove2=true;
   //逐个属性进行判断
   currentknowledge=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentknowledge,0);

   if(currentknowledge>=2){
      blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge +=1;
      await showToast("玩家${currentplayername}知识检定为2以上，知识提升1级");

   }
   else
   {
      allabove2=false;
      blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge -=1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge=1;
      await showToast("玩家${currentplayername}知识检定为2以下，知识降低1级");
   }
   currentmight=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentmight,0);
   if(currentmight>=2) {
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight += 1;
      await showToast("玩家${currentplayername}力量检定为2以上，力量提升1级");

   }
   else
   {
      allabove2=false;
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight -=1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentmight<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmight=1;
      await showToast("玩家${currentplayername}力量检定为2以下，力量降低1级");

   }
   currentspeed=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentspeed,0);

   if(currentspeed>=2) {
      blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed += 1;
      await showToast("玩家${currentplayername}速度检定为2以上，速度提升1级");

   }
   else
   {
      allabove2=false;
      blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed -=1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed=1;
      await showToast("玩家${currentplayername}速度检定为2以下，速度降低1级");

   }
   currentsanity=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentsanity,0);

   if(currentsanity>=2) {
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity += 1;
      await showToast("玩家${currentplayername}神志检定为2以上，神志提升1级");
   }
   else
   {
      allabove2=false;
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -=1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity=1;
      await showToast("玩家${currentplayername}神志检定为2以下，神志降低1级");

   }

   if(allabove2)
      {
         //弹窗选择属性
         showToast("玩家${currentplayername}全属性在2以上，请选择一项属性进行提升");
         int i=1;
         switch(i){
            case 1:
               blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge +=1;
            break;
            case 2:
               blackhouseGame.persons[blackhouseGame.currentplayer].currentmight +=1;
               break;
            case 3:
               blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed +=1;
               break;
            case 4:
               blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity +=1;
               break;
         }
      }

}

//16骇人尖叫
Future frighteningScreams(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“骇人尖叫”");
   await showEventCard(16,blackhouseGame);

   for (int i = 1; i <= blackhouseGame.playernum; i++) {
      int playerId=i;

      int currentsanitystage=blackhouseGame.persons[playerId].currentsanity;
      int currentsanity=blackhouseGame.persons[playerId].sanitylist[currentsanitystage];
      currentsanity=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentsanity,0);

      if(currentsanity>=4)
         await showToast("玩家${blackhouseGame.persons[playerId].playername}抵御住了尖叫声");
      else if(currentsanity>=1&&currentsanity<=3)
         {
            await showToast("玩家${blackhouseGame.persons[playerId].playername}神志为${currentsanity},需要受到1骰子精神伤害，正在掷骰子");
            await MantalDamageByDiceNum(context, 1, blackhouseGame, playerId);
         }
      else
         {
            await showToast("玩家${blackhouseGame.persons[i].playername}神志为${currentsanity},需要受到2骰子精神伤害，正在掷骰子");
            await MantalDamageByDiceNum(context, 2, blackhouseGame, playerId);
         }
   }
}

//17镜中影像
Future imageInMirror(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“镜中影像”");
   await showEventCard(17,blackhouseGame);

   int itemID=abandonItem(0, context, blackhouseGame, blackhouseGame.currentplayer);
   if(itemID!=0) {
      await showToast("舍弃了物品${blackhouseGame.itemsmap[itemID].cardname},提升1级知识");
      blackhouseGame.itemsmap[itemID].isopen = false;
   }
   await showToast("提升1级知识");

   //提升1级知识
   blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge +=1;
}

//18镜中影像
Future imageInMirror2(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“镜中影像”");
   await showEventCard(18,blackhouseGame);

   await showToast("抽取一张物品卡");
   await ItemEmit.triggerTheItem(context,blackhouseGame);

}

//19命中注定
Future destined(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“命中注定”");
   await showEventCard(19,blackhouseGame);

   //1.选择效果 查看牌堆或者是掷骰子
   //如果是查看牌堆，列出牌堆
   //展示牌堆的顶层三张，可自由调换顺序

   //2.如果是掷骰子，则保存下来，供下次提换
}

//20轮到约拿了
Future turnToJonah(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“轮到约拿了”");
   await showEventCard(20,blackhouseGame);

   if( blackhouseGame.itemsmap[29].ownerid!=0)
   {
      int ownerid=blackhouseGame.itemsmap[29].ownerid;
         await showToast("智益方块拥有者${blackhouseGame.persons[ownerid].playername}必须丢掉这个物品");
      int itemID=abandonItem(29,context,blackhouseGame,ownerid);
      if(itemID==0)
         await showToast("没有可以舍弃的物品");
      else
   //神志加1
   blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity +=1;
   }
   else
   {
         await showToast("没有人持有智益方块，玩家${currentplayername},需要受到1骰子精神伤害，正在掷骰子");
         await MantalDamageByDiceNum(context, 1, blackhouseGame, playerID);
   }
}

//21灯灭了
Future lightTurnDown(BlackHouseGame blackHouseGame,BuildContext context) async{
   String currentplayername=blackHouseGame.persons[blackHouseGame.currentplayer].playername;
   int mapid=blackHouseGame.persons[blackHouseGame.currentplayer].currentmapid;
   String mapname=blackHouseGame.maps[mapid].roomname;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“灯灭了”");
   await showEventCard(21,blackHouseGame);

   blackHouseGame.persons[blackHouseGame.currentplayer].eventslist.add(21);
   //拥有此牌时只能移动一格，满足条件时扔掉牌

}

//22保险箱
Future strongBox(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“保险箱”");
   await showEventCard(22,blackhouseGame);
   blackhouseGame.maps[mapid].strongboxflag =1;
   await showToast("玩家${currentplayername}在房间${mapname}放置保险箱标记");
   await showToast("玩家${currentplayername}进行开启保险箱判定");

   if(blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge>=5)
   {
      await showToast("抽取两张物品卡");   //完善抽取物品卡函数，调用两次
      await ItemEmit.triggerTheItem(context,blackhouseGame);
      await ItemEmit.triggerTheItem(context,blackhouseGame);
      blackhouseGame.maps[mapid].strongboxflag =0;
      await showToast("移除保险箱标记");
   }
   else if(blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge>=2&&blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge<=4)
   {
      await showToast("受到一骰子肉体伤害，保险箱没有打开");
      await BodyDamageByDiceNum(context, 1, blackhouseGame, playerID);
   }
   else if(blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge>=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge<=1)
   {
      print("受到两骰子肉体伤害，保险箱没有打开");
      await BodyDamageByDiceNum(context, 2, blackhouseGame, playerID);
   }
}

//23墙上雾霭
Future mistOnTheWall(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;

   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“墙上雾霭”");
   await showEventCard(23,blackhouseGame);

   for (int i = 1; i <= blackhouseGame.playernum; i++) {
      int playerID=i;
      //所有地下室的玩家
      if(blackhouseGame.maps[blackhouseGame.persons[playerID].currentmapid].currentlayer!=1) continue;
      int currentsanitystage=blackhouseGame.persons[playerID].currentsanity;
      int currentsanity=blackhouseGame.persons[playerID].sanitylist[currentsanitystage];
      if(currentsanity>=4)
         await showToast("玩家${blackhouseGame.persons[playerID].playername}没有受到伤害");
      else if(currentsanity>=1&&currentsanity<=3)
      {
         await showToast("玩家${blackhouseGame.persons[playerID].playername}神志为${currentsanity},需要受到1骰子精神伤害，正在掷骰子");
         if(blackhouseGame.maps[blackhouseGame.persons[i].currentmapid].eventflags!=0) {
            await showToast("房间存在事件标志，增加一骰子精神伤害");
            await MantalDamageByDiceNum(context, 2, blackhouseGame, playerID);
         }
         else await MantalDamageByDiceNum(context, 1, blackhouseGame, playerID);
      }
      else
      {
         await showToast("玩家${blackhouseGame.persons[playerID].playername}神志为${currentsanity},需要受到1骰子精神伤害，正在掷骰子");
         if(blackhouseGame.maps[blackhouseGame.persons[i].currentmapid].eventflags!=0) {
            await showToast("房间存在事件标志，增加2骰子精神伤害");
            await MantalDamageByDiceNum(context, 3, blackhouseGame, playerID);
         }
         else await MantalDamageByDiceNum(context, 1, blackhouseGame, playerID);
      }
   }
}
//24神秘滑梯
Future mysteriousSlide(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“神秘滑梯”");
   //放置滑梯上端标记
   blackhouseGame.maps[mapid].huatiupflag=1;
   await showEventCard(24,blackhouseGame);
   //可以尝试力量来放置滑道
   await setHuaDao(context,blackhouseGame,blackhouseGame.currentplayer);
   //放置滑梯下端标记
   blackhouseGame.maps[choosedMapID].huatidownflag=1;
   //把当前玩家放到新地图块，让主界面去刷新
   blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=choosedMapID;
}

//25暗夜幻想(by hxd)
Future nightFantasy(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“暗夜幻想”");
   await showEventCard(25,blackhouseGame);
   int currentknowledgestage = blackhouseGame.persons[playerID].currentknowledge;
   int currentknowledge = blackhouseGame.persons[playerID].knowledgelist[currentknowledgestage];
   await showToast("正在进行知识鉴定");
   currentknowledge=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentknowledge,0);

   if(currentknowledge>=5) {
      await showToast("玩家${currentplayername}知识为${currentknowledge}，知识提升1级");
      blackhouseGame.persons[playerID].currentknowledge += 1;
   }else{
      //后续完善：退回到上一个房间
   }
}

//26电话铃声(by hxd)
Future telephoneRing(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“电话铃声”");
   await showEventCard(26,blackhouseGame);

   await showToast("玩家${currentplayername}，正在掷骰子");
   int playerTotalDice = await rollTheDice(blackhouseGame,2);
   if(playerTotalDice==4){
      await showToast("玩家${currentplayername}神志为${blackhouseGame.persons[playerID].currentsanity}，神志提升1级");
      blackhouseGame.persons[playerID].currentsanity += 1;
   }else if(playerTotalDice==3){
      await showToast("玩家${currentplayername}精神为${blackhouseGame.persons[playerID].currentknowledge}，精神提升1级");
      blackhouseGame.persons[playerID].currentknowledge += 1;
   }else if(playerTotalDice==1||playerTotalDice==2){
      await showToast("玩家${blackhouseGame.persons[playerID].playername}需要受到1骰子精神伤害，正在掷骰子");
      await MantalDamageByDiceNum(context, 1, blackhouseGame, playerID);
   }else if(playerTotalDice==0){
      await showToast("玩家${blackhouseGame.persons[playerID].playername}需要受到2骰子物理伤害，正在掷骰子");
      await BodyDamageByDiceNum(context, 2, blackhouseGame, playerID);
   }
}
//27侵蚀(by hxd)
Future erode(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“侵蚀”");
   await showEventCard(27,blackhouseGame);
   int currentknowledgestage=blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge;
   int currentknowledge=blackhouseGame.persons[blackhouseGame.currentplayer].knowledgelist[currentknowledgestage];
   int currentmightstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentmight;
   int currentmight=blackhouseGame.persons[blackhouseGame.currentplayer].mightlist[currentmightstage];
   int currentspeedstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed;
   int currentspeed=blackhouseGame.persons[blackhouseGame.currentplayer].speedlist[currentspeedstage];
   int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];
   int chose = await chooseMentalDamageAll(context,blackhouseGame.persons[playerID]);//选择属性
   //后续完善 处于一阶段时等级讲到1，处于二阶段时等级降到0
   switch(chose){
      case 1:
         await showToast("玩家${currentplayername}选择对速度进行检定");
         currentspeed=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentspeed,0);

         if(currentspeed>=4){
            await showToast("玩家${currentplayername}速度为${blackhouseGame.persons[playerID].currentspeed}，速度提升1级");
            blackhouseGame.persons[playerID].currentspeed += 1;
         }else{
            await showToast("玩家${currentplayername}速度为${blackhouseGame.persons[playerID].currentspeed}，速度降低1级");
            blackhouseGame.persons[playerID].currentspeed = 1;
         }
         break;
      case 2:
         await showToast("玩家${currentplayername}选择对力量进行检定");
         currentmight=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentmight,0);

         if(currentmight>=4){
            await showToast("玩家${currentplayername}力量为${blackhouseGame.persons[playerID].currentmight}，力量提升1级");
            blackhouseGame.persons[playerID].currentmight += 1;
         }else{
            await showToast("玩家${currentplayername}力量为${blackhouseGame.persons[playerID].currentmight}，力量降低1级");
            blackhouseGame.persons[playerID].currentmight = 1;
         }
         break;
      case 3:
         await showToast("玩家${currentplayername}选择对神志进行检定");
         currentsanity=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentsanity,0);

         if(currentsanity>=4){
            await showToast("玩家${currentplayername}神志为${blackhouseGame.persons[playerID].currentsanity}，神志提升1级");
            blackhouseGame.persons[playerID].currentsanity += 1;
         }else{
            await showToast("玩家${currentplayername}神志为${blackhouseGame.persons[playerID].currentsanity}，神志降低1级");
            blackhouseGame.persons[playerID].currentsanity = 1;
         }
         break;
      case 4:
         await showToast("玩家${currentplayername}选择对知识进行检定");
         currentknowledge=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentknowledge,0);

         if(currentknowledge>=4){
            await showToast("玩家${currentplayername}知识为${blackhouseGame.persons[playerID].currentknowledge}，知识提升1级");
            blackhouseGame.persons[playerID].currentknowledge += 1;
         }else{
            await showToast("玩家${currentplayername}知识为${blackhouseGame.persons[playerID].currentknowledge}，知识降低1级");
            blackhouseGame.persons[playerID].currentknowledge = 1;
         }
         break;
   }
}

//28旋转墙
Future revolvingWall(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“旋转墙”");
   await showEventCard(28,blackhouseGame);
}

//29腐烂 modify by gaoyang 2021-1-14
Future Putrefaction(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   int currentmightstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentmight;
   int currentmight=blackhouseGame.persons[blackhouseGame.currentplayer].mightlist[currentmightstage];
   int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“腐烂”");
   await showEventCard(29,blackhouseGame);
   await showToast("正在进行神志检定");
   currentsanity=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentsanity,0);

   if(currentsanity>=5) {
      await showToast("玩家${currentplayername}神志为${currentsanity}，神志提升1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity += 1;
   }
   else if(currentsanity>=2&&currentsanity<=4){
      await showToast("玩家${currentplayername}力量为${currentmight}，力量降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight -= 1;
   }
   else if(currentsanity==1) {
      await showToast("玩家${currentplayername}力量为${currentmight}，力量降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight -= 1;
      await showToast("玩家${currentplayername}降低1级速度");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed -= 1;
      if (blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed < 1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed = 1;
   }else if(currentsanity==0){
      await showToast("玩家${currentplayername}力量为${currentmight}，力量降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight -= 1;
      await showToast("玩家${currentplayername}神志为${currentsanity}，神志降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -= 1;
      await showToast("玩家${currentplayername}降低1级速度");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed -= 1;
      if (blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed < 1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed = 1;
      await showToast("玩家${currentplayername}神志为${currentsanity}，知识为${blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge},知识降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge-= 1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge=1;
   }

}
//30秘密通道
Future secretPassage(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“秘密通道”");
   await showEventCard(30,blackhouseGame);
   blackhouseGame.maps[mapid].secretwayflag=1;  //放置秘密通道标志
   await showToast("玩家${currentplayername}，正在掷骰子");
   int playerTotalDice = await rollTheDice(blackhouseGame,3);
   if(playerTotalDice==6)
   {
      await showToast("请选择任意已有的所有房间");
    }
   else if(playerTotalDice>=4&&playerTotalDice<=5)
   {
      await showLayer(blackhouseGame,3);
   }
   else if(playerTotalDice>=2&&playerTotalDice<=3)
   {
      await showLayer(blackhouseGame,2);
   }
   else if(playerTotalDice>=0&&playerTotalDice<=1)
   {
      await showLayer(blackhouseGame,1);
   }
   //放置秘密通道标记
   blackhouseGame.maps[choosedMapID].secretwayflag=1;
   //把当前玩家放到新地图块，让主界面去刷新
   blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=choosedMapID;
}
//31秘密楼梯
Future secretStaircase(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“秘密楼梯”");
   await showEventCard(31,blackhouseGame);
   blackhouseGame.maps[mapid].secretstairsflag=1;  //放置秘密楼梯标志
   int currentlayer=blackhouseGame.maps[mapid].currentlayer;
   //选择上下一层
   int chooselayer=1;
   await showLayer(blackhouseGame,chooselayer);
   //放置秘密楼梯标记
   blackhouseGame.maps[choosedMapID].secretstairsflag=1;
   //是否穿过秘密楼梯弹框
   bool iscross=true;
   if(iscross)
      {
         //把当前玩家放到新地图块，让主界面去刷新
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=choosedMapID;
         //抽取一张事件卡
         await EventEmit.triggerTheEvent(context,blackhouseGame);
      }

}
//32尖啸狂风
Future HowlingWind(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“尖啸狂风”");
   await showEventCard(32,blackhouseGame);
   await showToast("正在进行力量检定");

   for(int i=1 ;i<blackhouseGame.playernum;i++) {
      int playermapid=blackhouseGame.persons[i].currentmapid;
      //不在露台、塔楼、花园、墓园、天井则不判断
      if(playermapid!=20&&playermapid!=24&&playermapid!=34&&playermapid!=35&&playermapid!=36)
         continue;

      int currentmightstage=blackhouseGame.persons[i].currentmight;
      int might=blackhouseGame.persons[i].mightlist[currentmightstage];
      might=await getDiceNum(context,blackhouseGame,i,might,0);

      String playernow=blackhouseGame.persons[i].playername;
      if (might >= 5) {
         await showToast("玩家${playernow}稳住了脚步");
      }
      else if (might >= 3 && might <= 4) {
         await showToast("狂风将玩家${playernow}击倒，受到1骰子物理伤害");
         await BodyDamageByDiceNum(context, 1, blackhouseGame, playermapid);
      }
      else if (might >= 1 && might <= 2) {
         await showToast("狂风吹透了玩家${playernow}的灵魂，受到1骰子精神伤害");
         await MantalDamageByDiceNum(context, 1, blackhouseGame, playermapid);
      }
      else if(might == 0)
      {
         await showToast("狂风将玩家${playernow}重重击倒，受到1骰子物理伤害");
         await BodyDamageByDiceNum(context, 1, blackhouseGame, playermapid);
         int itemID=abandonItem(0,context,blackhouseGame,i);
         if(itemID==0)
            await showToast("没有可以舍弃的物品");
         else
         await showToast("狂风将玩家${playernow}的物品${blackhouseGame.itemsmap[itemID].cardname}吹到了入口大厅");
      }
   }
}

//33寂静(by hxd)
Future silent(BlackHouseGame blackhouseGame,BuildContext context) async {
   String currentplayername = blackhouseGame.persons[blackhouseGame
       .currentplayer].playername;
   int mapid = blackhouseGame.persons[blackhouseGame.currentplayer]
       .currentmapid;
   String mapname = blackhouseGame.maps[mapid].roomname;
   int playerID = blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“寂静”");
   await showEventCard(33, blackhouseGame);
   for (int i = 1; i <= blackhouseGame.playernum; i++) {
      int playerID = i;
      //所有地下室的玩家
      if (blackhouseGame.maps[blackhouseGame.persons[playerID].currentmapid]
          .currentlayer != 1) continue;

      int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
      int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];
      if (currentsanity >= 4) {
         await showToast(
             "玩家${blackhouseGame.persons[playerID].playername}没有受到伤害");
      } else if (currentsanity >= 1 && currentsanity <= 3) {
         await showToast("玩家${blackhouseGame.persons[playerID]
             .playername}神志为${currentsanity},需要受到1骰子精神伤害，正在掷骰子");
         await MantalDamageByDiceNum(context, 1, blackhouseGame, playerID);
      } else {
         await showToast("玩家${blackhouseGame.persons[playerID]
             .playername}神志为${currentsanity},需要受到2骰子精神伤害，正在掷骰子");
         await MantalDamageByDiceNum(context, 2, blackhouseGame, playerID);
      }
   }
}
//34骸骨（by hxd）
Future humanBones(BlackHouseGame blackhouseGame,
    BuildContext context) async {
   String currentplayername = blackhouseGame.persons[blackhouseGame
       .currentplayer].playername;
   int mapid = blackhouseGame.persons[blackhouseGame.currentplayer]
       .currentmapid;
   String mapname = blackhouseGame.maps[mapid].roomname;
   int playerID = blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“骸骨”");
   await showEventCard(34, blackhouseGame);
   blackhouseGame.maps[mapid].boneflag =1;
   await showToast("玩家${currentplayername}在房间${mapname}放置骸骨标记");
   await showToast("玩家${blackhouseGame.persons[playerID]
       .playername}神志为${blackhouseGame.persons[playerID].currentsanity},需要受到1骰子精神伤害，正在掷骰子");
   await MantalDamageByDiceNum(context, 1, blackhouseGame, playerID);

   int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];
   int chose = await choseDialog(context,"是否通过检定神志探索骸骨一次");
   if(chose==1){//是
      await showToast("玩家${currentplayername}选择对神志进行检定");
      currentsanity=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentsanity,0);

      if(currentsanity>=5){
         await showToast("抽取一张物品卡");   //完善抽取物品卡函数，调用一次
         await ItemEmit.triggerTheItem(context,blackhouseGame);
      }else{
         await showToast("玩家${blackhouseGame.persons[playerID]
             .playername}神志为${currentsanity},需要受到2骰子精神伤害，正在掷骰子");
         await MantalDamageByDiceNum(context, 2, blackhouseGame, playerID);
      }
   }
}
//35烟雾
Future smoke(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“烟雾”");
   await showEventCard(35,blackhouseGame);
   blackhouseGame.maps[mapid].smokeflag =1;
   await showToast("玩家${currentplayername}在房间[${mapname}]放置烟雾标记");

   blackhouseGame.maps[mapid].dicenum -=2;
   await showToast("每位玩家在房间内掷骰子时减少两枚骰子");
}

//36隐藏物品 modify my gaoyang 2021-1-14
Future hiddenItems(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“隐藏物品”");
   await showEventCard(36,blackhouseGame);
   int currentknowledgestage=blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge;
   int currentknowledge=blackhouseGame.persons[blackhouseGame.currentplayer].knowledgelist[currentknowledgestage];

   int isok = await choseDialog(context,"如果你想弄清楚房间内到底哪里奇怪，可以尝试一次知识检定");
   print("${isok}");
   if(isok == 1){
      await showToast("正在进行知识检定");
      currentknowledge=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentknowledge,0);

      if(currentknowledge >=4){
         {
            await showToast("抽取物品卡"); //待实现
            await ItemEmit.triggerTheItem(context,blackhouseGame);
         }
      }else if(currentknowledge>=0 && currentknowledge<=3){
         await showToast("玩家${currentplayername}就是搞不明白,有点狂躁,神志降低1级");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -= 1;
      }
   }

}
//37黏滑的东西 modify by gaoyang 2021-1-14
Future slimyStuff(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“黏滑的东西”");
   await showEventCard(37,blackhouseGame);
   await showToast("正在进行速度检定");
   int currentmightstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentmight;
   int currentmight=blackhouseGame.persons[blackhouseGame.currentplayer].mightlist[currentmightstage];
   int currentspeedstage = blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed;
   int currentspeed = blackhouseGame.persons[blackhouseGame.currentplayer].speedlist[currentspeedstage];
   currentspeed=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentspeed,0);

   if(currentspeed >= 4){
      await showToast("玩家${currentplayername}你逃脱了，提升1级速度");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed += 1;
   }else if(currentspeed >=1 && currentspeed <=3){
      await showToast("玩家${currentplayername}力量为${currentmight}，力量降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight -= 1;
   }else if(currentspeed ==0){
      await showToast("玩家${currentplayername},降低1级速度");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed -= 1;
      await showToast("玩家${currentplayername}力量为${currentmight}，力量降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight -= 1;
   }

}
//38蜘蛛(by hxd)
Future spider(BlackHouseGame blackhouseGame, BuildContext context) async {
   String currentplayername = blackhouseGame.persons[blackhouseGame
       .currentplayer].playername;
   int mapid = blackhouseGame.persons[blackhouseGame.currentplayer]
       .currentmapid;
   String mapname = blackhouseGame.maps[mapid].roomname;
   int playerID = blackhouseGame.currentplayer;
   int currentknowledgestage=blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge;
   int currentknowledge=blackhouseGame.persons[blackhouseGame.currentplayer].knowledgelist[currentknowledgestage];
   int currentmightstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentmight;
   int currentmight=blackhouseGame.persons[blackhouseGame.currentplayer].mightlist[currentmightstage];
   int currentspeedstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed;
   int currentspeed=blackhouseGame.persons[blackhouseGame.currentplayer].speedlist[currentspeedstage];
   int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“蜘蛛”");
   await showEventCard(38, blackhouseGame);
   int chose = await chooseMentalDamageAll(context, blackhouseGame.persons[playerID],
       list: ["速度 ${blackhouseGame.persons[playerID].currentspeed}", "神志 ${blackhouseGame.persons[playerID].currentsanity}"]); //选择属性
   switch (chose) {
      case 1:
         await showToast("玩家${currentplayername}选择对速度进行检定");
         currentspeed=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentspeed,0);

         if (currentspeed >= 4) {
            await showToast("玩家${currentplayername}速度为${currentspeed}，速度提升1级");
            blackhouseGame.persons[playerID].currentspeed += 1;
         } else if (currentspeed >= 1 && currentspeed <= 3) {
            await showToast("玩家${currentplayername}速度为${currentspeed}，需要受到1骰子物理伤害，正在掷骰子");
            await BodyDamageByDiceNum(context, 1, blackhouseGame, playerID);
         } else {
            await showToast("玩家${currentplayername}速度为${currentspeed}，需要受到2骰子物理伤害，正在掷骰子");
            await BodyDamageByDiceNum(context, 2, blackhouseGame, playerID);
         }
         break;
      case 2:
         await showToast("玩家${currentplayername}选择对神志进行检定");
         currentmight=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentmight,0);

         if (currentmight >= 4) {
            await showToast("玩家${currentplayername}神志为${currentmight}，神志提升1级");
            blackhouseGame.persons[playerID].currentmight += 1;
         } else if (currentmight >= 1 && currentmight <= 3) {
            await showToast("玩家${currentplayername}神志为${currentmight}，需要受到1骰子物理伤害，正在掷骰子");
            await BodyDamageByDiceNum(context, 1, blackhouseGame, playerID);
         } else {
            await showToast("玩家${currentplayername}神志为${currentmight}，需要受到2骰子物理伤害，正在掷骰子");
            await BodyDamageByDiceNum(context, 2, blackhouseGame, playerID);
         }
         break;
   }
}

//39 呼唤 放在主界面中

//40迷失的人
Future lostPeople(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“迷失的人”");
   await showEventCard(40,blackhouseGame);
   await showToast("正在进行知识检定");
   int currentknowledgestage=blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge;
   int currentknowledge=blackhouseGame.persons[blackhouseGame.currentplayer].knowledgelist[currentknowledgestage];
   currentknowledge=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentknowledge,0);

   if(currentknowledge >=5){
      await showToast("你打破了催眠并提升了1级知识");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge +=1;
   }
   else{
      await showToast("掷3枚骰子看迷失的人将你带往何处");
      int playerTotalDice=0;
      playerTotalDice=await rollTheDice(blackhouseGame,3);

      if(playerTotalDice==6){
         await showToast("玩家${currentplayername}被带到了入口大厅");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=3;
      }
      else if(playerTotalDice>=4&&playerTotalDice<=5){
         await showToast("玩家${currentplayername}被带到了上层起点处");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=4;
      }
      else if(playerTotalDice>=2&&playerTotalDice<=3){
         await showToast("玩家${currentplayername}被带到了上层某一个房间");
         //上层是否有可用房间
         List<int> maplist=await hasMaps(blackhouseGame,3);
         print("maplistlength${maplist.length}");
         //如果有，则抽取房间
         if(maplist.length>0) {
            await showToast("请选择上层任意房间开门出进行房间探索");
            await chooseRoomDoorsOfLayer(blackhouseGame, 3);
         }
         else{
            await showToast("没有找到合适的房间，玩家${currentplayername}被带到了入口大厅");
            blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=3;
         }
      }
      else if(playerTotalDice>=0&&playerTotalDice<=1){
         await showToast("玩家${currentplayername}被带到了地下室某一个房间");
         //地下室是否有可用房间
         List<int> maplist=await hasMaps(blackhouseGame,1);
         print("maplistlength${maplist.length}");
         //如果有，则抽取房间
         if(maplist.length>0) {
            await showToast("请选择地下室任意房间开门出进行房间探索");
            await chooseRoomDoorsOfLayer(blackhouseGame, 1);
         }
         else{
            await showToast("没有找到合适的房间，玩家${currentplayername}被带到了入口大厅");
            blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=3;
         }
      }
   }
}
//41声音 modify by gaoyang 2021-1-14
Future sound(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;

   int currentknowledgestage=blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge;
   int currentknowledge=blackhouseGame.persons[blackhouseGame.currentplayer].knowledgelist[currentknowledgestage];

   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“声音”");
   await showEventCard(41,blackhouseGame);
   await showToast("正在进行知识检定");
   currentknowledge=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentknowledge,0);

   if(currentknowledge >=4){
      await showToast("抽取物品卡"); //待实现
      await ItemEmit.triggerTheItem(context,blackhouseGame);
   }else if(currentknowledge >= 0 && currentknowledge <=3){
      await showToast("你在地板上挖了一圈,什么也没有找到");
   }

}
//42墙壁
Future wall(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“墙壁”");
   await showEventCard(42,blackhouseGame);
   bool ismatch=false;
   int count=0;
   var rng = new Random();
   int num = rng.nextInt(4);
   num += 1;
   while(!ismatch||count>=4) {
      //先随机一层
      await showToast("玩家${currentplayername}陷入墙壁出现在了另一个房间");
      //地下室是否有可用房间
      List<int> maplist = await hasMaps(blackhouseGame, num);
      print("maplistlength${maplist.length}");
      //如果有，则抽取房间
      if (maplist.length > 0) {
         await chooseRoomDoorsOfLayer(blackhouseGame, num);
         ismatch=true;
      }
      num=num+1;
      if(num>4) num=1;
      count++;
   }
   if(count==4){
      await showToast("各层均无适合的房间，玩家出现在地下室");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=5;}
}
//43蛛网 modify by gaoyang 2021-1-14
Future cobweb(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“蛛网”");
   int currentmightstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentmight;
   int currentmight=blackhouseGame.persons[blackhouseGame.currentplayer].mightlist[currentmightstage];
   await showEventCard(43,blackhouseGame);
   await showToast("正在进行力量检定");
   currentmight=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentmight,0);

   if(currentmight>=4) {
      await showToast("玩家${currentplayername},你摆脱了蛛网，力量提升1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight += 1;
   }else if(currentmight >=0 && currentmight <=3){
      await showToast("玩家${currentplayername},你被困住了");
      blackhouseGame.persons[blackhouseGame.currentplayer].eventslist.add(43);
      //别的玩家回合要判断
      blackhouseGame.eventsmap[8].ownerid=blackhouseGame.currentplayer;
      blackhouseGame.persons[blackhouseGame.currentplayer].walinum=3;  //为0的时候才能行动，别的玩家回合可以选择判断力量4+来救你
   }

}


//45哎呀！
Future aiya(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“哎呀！”");
   await showEventCard(45,blackhouseGame);
   int itemID=abandonItem(0,context,blackhouseGame,playerID);
   if(itemID==0)
      await showToast("没有可以舍弃的物品");
   else
   await showToast("右侧玩家随机弃掉了你的物品${blackhouseGame.itemsmap[itemID].cardname}");
}
//46针刺
Future acupuncture(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“针刺”");
   await showEventCard(46,blackhouseGame);
   int chooseID=1;
   //进入相邻的门并降低一级神志
   if(chooseID==1)
    {
          await showToast("玩家${currentplayername}在房间${mapname}进入了相邻的门，并降低了一级神志");
          blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -=1;
          //优先需要探索的门
         if(blackhouseGame.maps[mapid].leftdoor!=0&&blackhouseGame.maps[mapid].theleftroom==0)
         {
             choosedMapID = mapid;
             chooseMapDoor = 1;
             return ;
         }
         if(blackhouseGame.maps[mapid].rightdoor!=0&&blackhouseGame.maps[mapid].therightroom==0)
         {
            choosedMapID = mapid;
            chooseMapDoor = 2;
            return ;
         }
         if(blackhouseGame.maps[mapid].updoor!=0&&blackhouseGame.maps[mapid].theuproom==0)
         {
            choosedMapID = mapid;
            chooseMapDoor = 3;
            return ;
         }
         if(blackhouseGame.maps[mapid].downdoor!=0&&blackhouseGame.maps[mapid].thedownroom==0)
         {
            choosedMapID = mapid;
            chooseMapDoor = 4;
            return ;
         }
         //如果都探索过了，随机走入一个门
          var rng = new Random();
          int num = rng.nextInt(4);
          num += 1;
          choosedMapID = mapid;
          chooseMapDoor = num;
    }
   //进行力量检测
   else{
      await showToast("正在进行力量检定");
      int currentmightstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentmight;
      int currentmight=blackhouseGame.persons[blackhouseGame.currentplayer].mightlist[currentmightstage];
      currentmight=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentmight,0);

      if(currentmight>=5) {
         await showToast("玩家${currentplayername}力量为${currentmight}，力量提升1级,速度提升1级，神志提升1级");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmight += 1;
         blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed+= 1;
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity += 1;
      }
      else if(currentmight>=3&&currentmight<=4)
      {
         await showToast("玩家${currentplayername}力量为${currentmight}，力量提升1级,速度提升1级");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmight += 1;
         blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed+= 1;
      }
      else if(currentmight>=0&&currentmight<=2)
      {
         await showToast("玩家${currentplayername}力量为${currentmight}，力量降低1级,速度降低1级");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmight -= 1;
         blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed-= 1;
         if(blackhouseGame.persons[blackhouseGame.currentplayer].currentmight<1)
            blackhouseGame.persons[blackhouseGame.currentplayer].currentmight=1;
         if(blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed<1)
            blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed= 1;
      }
   }
}
//47冢
Future grave(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“冢”");
   await showEventCard(47,blackhouseGame);
   await showToast("玩家${currentplayername}在房间${mapname}放置了“冢”标记");
   blackhouseGame.maps[mapid].tombsflag=1;
}
//48合约 modify by gaoyang 2021-1-14  await showToast("抽取1张物品卡"); //待实现
Future contract(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   int currentknowledge=blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“合约”");
   await showEventCard(48,blackhouseGame);
   int isok = await choseDialog(context,"你可以签下合约并进行知识检定");
   if(isok == 1){
      currentknowledge=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentknowledge,0);

      if(currentknowledge >=0 && currentknowledge <=1){
         await showToast("你失去了灵魂,但什么也没得到");
         await showToast("玩家${currentplayername}神志为${currentsanity}，神志降低1级");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -= 1;
      }else  if(currentknowledge >=2 && currentknowledge <=3){
         await showToast("你失去了灵魂,但获得了力量");
         await showToast("玩家${currentplayername}神志为${currentsanity}，神志降低1级");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -= 1;
         await showToast("抽取1张物品卡"); //待实现
         await ItemEmit.triggerTheItem(context,blackhouseGame);
      }else  if(currentknowledge == 4){
         await showToast("你找到了一个漏洞保住了自己的灵魂");
         await showToast("抽取1张物品卡"); //待实现
         await ItemEmit.triggerTheItem(context,blackhouseGame);
      }else if(currentknowledge >=5){
         await showToast("你发现合约没有生效并保住了灵魂");
         await showToast("玩家${currentplayername}神志为${currentsanity}，神志提升1级");
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity += 1;
         await showToast("抽取1张物品卡"); //待实现
         await ItemEmit.triggerTheItem(context,blackhouseGame);
      }
   }
}
//49捕蝇草
Future dionaeaMuscipula(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“捕蝇草”");
   await showEventCard(49,blackhouseGame);
   await showToast("玩家${currentplayername}在房间${mapname}设置了“捕蝇草”标记，并拿走了捕蝇草");
   blackhouseGame.maps[mapid].plantflag=1;
   blackhouseGame.persons[blackhouseGame.currentplayer].eventslist.add(49);
   blackhouseGame.eventsmap[49].ownerid=blackhouseGame.currentplayer;
   //拿有此牌是可以发动攻击的
}
//50机器里的鬼魂
Future goastInMachine(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“机器里的鬼魂”");
   await showEventCard(50,blackhouseGame);
   await showToast("正在进行神志检定");
   int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].mightlist[currentsanitystage];
   currentsanity=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentsanity,0);

   if(currentsanity>=3) {
      List<int> maplist=await hasMaps(blackhouseGame,4);
      print("maplistlength${maplist.length}");
      //如果有，则抽取房间
      if(maplist.length>0) {
         await showToast("请选择顶层任意房间开门出进行房间探索");
         await chooseRoomDoorsOfLayer(blackhouseGame, 4);
      }
      else{
         await showToast("顶层没有合适房间可供探索");
      }
   }
   else{
      await showToast("玩家${currentplayername}降低了一级力量，所有冒险者在${currentplayername}下一轮前只能移动一格");
      //拿到这张牌，下一轮扔掉来判断其他冒险者移动多少
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight -= 1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentmight<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmight=1;
   }
}
//51雷击
Future lightningStrike(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“雷击”");
   await showEventCard(51,blackhouseGame);
   int tempplayerid=playerID;
   for(int i=0 ;i<blackhouseGame.playernum;i++) {
      int playermapid = blackhouseGame.persons[tempplayerid].currentmapid;
      //不在露台、塔楼、花园、墓园、天井则不判断
      if (playermapid == 20 || playermapid == 24 || playermapid == 34 ||
          playermapid == 35 || playermapid == 36|| blackhouseGame.maps[playermapid].currentlayer==4) {
         await showToast("正在进行力量检定");
         int currentmightstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentmight;
         int currentmight=blackhouseGame.persons[blackhouseGame.currentplayer].mightlist[currentmightstage];
         currentmight=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentmight,0);

         if(currentmight>=4) {
            await showToast("玩家${currentplayername}遭受雷击，但什么都没有发生");
         }
         else if(currentmight>=1&&currentmight<=3)
         {
            await showToast("玩家${currentplayername}力量为${currentmight}，受到1点物理伤害，正在掷骰子");
            await BodyDamageByDiceNum(context, 1, blackhouseGame, playerID);
         }
         else if(currentmight==0)
         {
            await showToast("玩家${currentplayername}力量为${currentmight}，受到2点物理伤害，正在掷骰子");
            await BodyDamageByDiceNum(context, 2, blackhouseGame, playerID);
         }
      }
      else{
         tempplayerid = tempplayerid + 1;
         if (tempplayerid > 6)
            tempplayerid = 1;
         continue;
      }
   }
}
//52迷雾拱门
Future fogArch(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“迷雾拱门”");
   await showEventCard(52,blackhouseGame);
   bool iscomein=true;
   if(iscomein)
      {
         int playerTotalDice=0;
         await showToast("玩家${currentplayername}进行掷3颗骰子进行拱门判定");
         playerTotalDice=await rollTheDice(blackhouseGame,3);
         if(playerTotalDice==0)
            {
               int itemID=abandonItem(0,context,blackhouseGame,playerID);

               blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=3;
               if(itemID==0)
                  await showToast("没有可以舍弃的物品");
               else
               await showToast("玩家${currentplayername}被移动到了入口大厅，并失去了物品${blackhouseGame.itemsmap[itemID].cardname}");
            }
         else if(playerTotalDice>=1&&playerTotalDice<=2)
            {
               blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=3;
               blackhouseGame.persons[blackhouseGame.currentplayer].currentmight=blackhouseGame.persons[blackhouseGame.currentplayer].initmight;
               blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed=blackhouseGame.persons[blackhouseGame.currentplayer].initspeed;
               blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].initsanity;
               blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge=blackhouseGame.persons[blackhouseGame.currentplayer].initknowledge;
               await showToast("玩家${currentplayername}被移动到了入口大厅，并发生了莫名奇妙的变化，被重置所有属性到初始值");
            }
         else if((playerTotalDice>=3&&playerTotalDice<=4)||(playerTotalDice>=5&&playerTotalDice<=6))
            {
               await showToast("玩家${currentplayername}被移动到了任意房门开启的房间");
               bool ismatch=false;
               int count=0;
               var rng = new Random();
               int num = rng.nextInt(4);
               num += 1;
               while(!ismatch||count>=4) {
                  //先随机一层
                  List<int> maplist = await hasMaps(blackhouseGame, num);
                  print("maplistlength${maplist.length}");
                  //如果有，则抽取房间
                  if (maplist.length > 0) {
                     await chooseRoomDoorsOfLayer(blackhouseGame, num);
                     ismatch=true;
                  }
                  num=num+1;
                  if(num>4) num=1;
                  count++;
               }
               if(count==4){
                  await showToast("各层均无适合的房间，玩家出现在地下室");
                  blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=5;}

               if(playerTotalDice>=5&&playerTotalDice<=6)
               {
                  int itemID=abandonItem(0,context,blackhouseGame,playerID);
                  if(itemID==0)
                     await showToast("没有可以舍弃的物品");
                  else
                    await showToast("玩家${currentplayername}弃掉了一张物品卡${blackhouseGame.itemsmap[itemID].cardname}");
               }
            }
      }
}
//53变异宠物 modify by gaoyang 2021-1-14
Future mutantPet(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   int currentspeedstage=blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed;
   int currentspeed=blackhouseGame.persons[blackhouseGame.currentplayer].speedlist[currentspeedstage];
   int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
   int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];

   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“变异宠物”");
   await showEventCard(53,blackhouseGame);
   await showToast("正在进行速度检定");
   currentspeed=await getDiceNum(context,blackhouseGame,blackhouseGame.currentplayer,currentspeed,0);

   if(currentspeed >=4){
      await showToast("速度检定成功");
      await showToast("玩家${currentplayername}神志为${currentsanity}，神志提升1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity += 1;
      await showToast("玩家${currentplayername},提升1级速度");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentspeed += 1;
   }else{
      await showToast("速度检定失败,有宠物攻击,你受到1点物理伤害");
      await BodyDamageByDiceNum(context, 1, blackhouseGame, playerID);
   }
}
//54左手
Future leftHand(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“左手”");
   await showEventCard(54,blackhouseGame);
   int choose=1;
   if(choose==1){
      await showToast("玩家${currentplayername}砍掉了左手，降低1级力量，提升1级神志");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity += 1;
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight-= 1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentmight<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmight = 1;
   }
   else if(choose==2){
      await showToast("玩家${currentplayername}换掉了左手，降低1级力量，抽取了1张物品卡");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight-= 1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity = 1;
      await  ItemEmit.triggerTheItem(context, blackhouseGame);
   }
   else if(choose==3){
      await showToast("玩家${currentplayername}留下了左手，降低2级神志，提升1级力量");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -= 2;
      blackhouseGame.persons[blackhouseGame.currentplayer].currentmight+= 1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity<1)
         blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity = 1;

      await showToast("玩家${currentplayername}移至最近一个有预兆标志的房间，并抽取了一张预兆卡");
      double mindistance = 10000;
      int mindistancemapid=0;
      for (int i = 1; i <= blackhouseGame.maps.length; i++) {
         if ((blackhouseGame.maps[i].currentlayer == blackhouseGame.currentplayer)&&blackhouseGame.maps[i].omenflags==1) {
            var dx = blackhouseGame.mapcoordinate[i].x -
                blackhouseGame.mapcoordinate[blackhouseGame.currentplayer].x;
            var dy = blackhouseGame.mapcoordinate[i].y -
                blackhouseGame.mapcoordinate[blackhouseGame.currentplayer].y;
            double distance = sqrt(dx * dx + dy * dy);
            if (distance <= mindistance) {
               mindistance = distance;
               mindistancemapid = i;
            }
         }
      }
      //移动到该房间，并抽预兆卡
      if(mindistancemapid!=0){
         blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=mindistancemapid;
         await OmensEmit.triggerTheOmen(context, blackhouseGame);
      }
      else{
         await showToast("没有适合的预兆房间，不触动卡牌效果");
      }
   }
}
//56今夕是何年
Future whichYear(BlackHouseGame blackhouseGame,BuildContext context) async{
   String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
   int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
   String mapname=blackhouseGame.maps[mapid].roomname;
   int playerID=blackhouseGame.currentplayer;
   await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“今夕是何年”");
   await showEventCard(56,blackhouseGame);
   await showToast("玩家${currentplayername}降低1级神志，提升1级力量和1级知识");
   blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -= 1;
   blackhouseGame.persons[blackhouseGame.currentplayer].currentmight+= 1;
   blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge+= 1;
   if(blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity<1)
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity = 1;

   blackhouseGame.eventsmap[56].ownerid=playerID;
   blackhouseGame.persons[blackhouseGame.currentplayer].eventslist.add(56);
   //如果进入第二阶段，则显示对方的故事引言和尾声
}
