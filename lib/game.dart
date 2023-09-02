import 'dart:io';

import 'package:blackhouse/config/param.dart';
import 'package:blackhouse/maps/map.dart';
import 'package:blackhouse/maps/showLayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blackhouse/game/blackhousegame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blackhouse/widgets/png_button.dart';
import 'package:blackhouse/widgets/joy_stick.dart';
import 'package:blackhouse/widgets/arrow_button.dart';
import 'package:blackhouse/widgets/middle_arrow_button.dart';
import 'package:blackhouse/cards/eventCards/emittheevent.dart' as Events;
import 'package:blackhouse/cards/itemsCards/emittheitem.dart' as Items;
import 'package:blackhouse/cards/omensCards/emittheomen.dart' as Omens;
import 'package:blackhouse/cards/itemsCards/itemsfuction.dart' as ItemFunction;

import 'package:blackhouse/tools/cardstools.dart';
import 'dart:ui';
import 'dart:math';
import 'package:blackhouse/tools/cardstools.dart';
import 'package:blackhouse/cards/itemsCards/emittheitem.dart' as ItemEmit;



class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final BlackHouseGame blackhouseGame = BlackHouseGame();

  //左边房间箭头的可见属性
  bool leftroom_leftarrow_offset=true;
  bool leftroom_uparrow_offset=true;
  bool leftroom_rightarrow_offset=true;
  bool leftroom_downarrow_offset=true;
  bool leftroom_middlearrow_offset=true;

  //中间房间箭头的可见属性
  bool middleroom_leftarrow_offset=true;
  bool middleroom_uparrow_offset=true;
  bool middleroom_rightarrow_offset=true;
  bool middleroom_downarrow_offset=true;
  bool middleroom_middlearrow_offset=true;


  //右边房间箭头的可见属性
  bool rightroom_leftarrow_offset=true;
  bool rightroom_uparrow_offset=true;
  bool rightroom_rightarrow_offset=true;
  bool rightroom_downarrow_offset=true;
  bool rightroom_middlearrow_offset=true;

  bool rotateMapblockWidget_offset=false;
  String currentNeedDirection="";    //抽出卡牌需要的对接方向

  bool dice_offset=false;
  bool tip_offset=false;
  bool isfirstload=true;

  bool ishidearrows=true;




  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshArrows();
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!isfirstload)
    refreshArrows();
    isfirstload=false;
    return  Stack(
        children: [
        blackhouseGame.widget,
        //左边地图块的向左方向键按钮--------------------------------------------------------------------
        leftroom_leftarrow(),
        //中间地图块的向左方向键按钮
        middleroom_leftarrow(),
        //右边地图块的向左方向键按钮
        rightroom_leftarrow(),
       //左边地图块的向上方向键按钮--------------------------------------------------------------------------
        leftroom_uparrow(),
        //中间地图块的向上方向键按钮
        middleroom_uparrow(),
        //右边地图块的向上方向键按钮
        rightroom_uparrow(),
        //左边地图块的向右方向键按钮-------------------------------------------------------------------
        leftroom_rightarrow(),
        //中间地图块的向右方向键按钮
        middleroom_rightarrow(),
        //右边地图块的向右方向键按钮
        rightroom_rightarrow(),
        //左边地图块的向下方向键按钮------------------------------------------------------------------------
        lefttroom_downarrow(),
        //中间地图块的向下方向键按钮
        middletroom_downarrow(),
        //右边地图块的向下方向键按钮
        righttroom_downarrow(),
        //左边地图块的正中间方向键按钮------------------------------------------------------------------------
        leftroom_middlearrow(),
        //中间地图块的正中间方向键按钮
        middleroom_middlearrow(),
        //右边地图块的向正中间向键按钮
        rightroom_middlearrow(),
        //行动提示
          tipsWidget(),
        //下方的工具栏骰子按钮------------------------------------------------------------------------------
          diceWidget(),
        //小地图
          littlemapWidget()
      ],
    );
  }


  //提示栏
  Widget tipsWidget()
  {
    return Positioned(
        top:  ScreenUtil().setHeight(750)/8,
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1050))/2+ScreenUtil().setWidth(600),
        child:Offstage(
          offstage: tip_offset,
          child:Container(
              padding: EdgeInsets.only(right:ScreenUtil().setHeight(250)),
              child:Text(
                  blackhouseGame!=null&&blackhouseGame.persons.length>0?"玩家${blackhouseGame.currentplayer}在行动，剩余${blackhouseGame.persons[blackhouseGame.currentplayer].step}步":"",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ))),
        ));
  }

  //骰子
  Widget diceWidget()
  {
    return Positioned(
        top:  ScreenUtil().setHeight(750)/8*6,
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1050))/2+ScreenUtil().setWidth(860),
        child:Offstage(
          offstage: dice_offset,
          child: Container(
              padding: EdgeInsets.only(right:ScreenUtil().setHeight(250)),
              child:PNGButton(
                  imagepath: "assets/images/dice.png",
                  onTap:() async{

                  }
              )),
        ));
  }

  //小地图
  Widget littlemapWidget()
  {
    return Positioned(
      top:  ScreenUtil().setHeight(750)/8,
      left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1050))/2+ScreenUtil().setWidth(1000),
      child: Container(
          padding: EdgeInsets.only(right:ScreenUtil().setHeight(250)),
          child:PNGButton(
              imagepath: "assets/images/mpIcon.png",
              onTap:() async{
                int leftid=blackhouseGame.currentleftmap.mapid;
                int middleid=blackhouseGame.currentmiddlemap.mapid;
                int rightid=blackhouseGame.currentrightmap.mapid;
                if(blackhouseGame.currentleftmap.currentlayer!=0)
                  blackhouseGame.showlayer=blackhouseGame.currentleftmap.currentlayer;
                else if(blackhouseGame.currentmiddlemap.currentlayer!=0)
                  blackhouseGame.showlayer=blackhouseGame.currentmiddlemap.currentlayer;
                else if(blackhouseGame.currentrightmap.currentlayer!=0)
                  blackhouseGame.showlayer=blackhouseGame.currentrightmap.currentlayer;
                blackhouseGame.currentleftmap=null;
                blackhouseGame.currentmiddlemap=null;
                blackhouseGame.currentrightmap=null;
                blackhouseGame.currenchoosemap=null;
                blackhouseGame.isshowlittemap=true;
                dice_offset=true;
                tip_offset=true;
                setState(() {
                });

                await showlittlemapDialog(context);
                blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
                blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
                blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
                blackhouseGame.isshowlittemap=false;
                dice_offset=false;
                tip_offset=false;
                setState(() {
                });
                refreshPlayers();
              }
          )),
    );
  }

  //左边地图块的向左方向键按钮
  Widget leftroom_leftarrow()
  {
    return Positioned(
      //设置定位，
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(210),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(60),
        child:Offstage(
          offstage: leftroom_leftarrow_offset,
          child: Container(
              child:ArrowButton(
                  direction: "left",
                  isopen: blackhouseGame.currentleftmap==null?false:blackhouseGame.currentleftmap.theleftroom!=0,
                  onTap:() async{
                    await leftroom_leftarrow_fun();
                  }

              )),
        ));
  }

  Future leftroom_leftarrow_fun() async{
    //如果左边地图块左边的房间号不为0，即已经探索过了，则把其左边的房间放置在地图块的最右边，并展开这个房间左边的两个房间
    //如果左边的两个房间为空的，就用黑色块补齐
    hideArrows();
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="left";
    double x=(blackhouseGame.leftoffset.dx-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/10;
    double y=(blackhouseGame.leftoffset.dy+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/x.abs();
    bool isemitcard=blackhouseGame.currentleftmap.theleftroom==0;

    if(blackhouseGame.currentleftmap.theleftroom!=0)
    {

      for(int i=0;i<x.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 50), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
        });
      }
      blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentleftmap.theleftroom];
      if(blackhouseGame.currentrightmap.theleftroom!=0)
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentrightmap.theleftroom];
        if(blackhouseGame.currentmiddlemap.theleftroom!=0)
        {
          blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theleftroom];
        }
        else blackhouseGame.currentleftmap=blackhouseGame.maps[101];
      }
      else
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentleftmap=blackhouseGame.maps[101];
      };
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
    }
    //如果左边房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在地图块的最右边
    //左边的两个房间为空的，就用黑色块补齐
    else{
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentleftmap,"left");
      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);

        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;

        //需要左边的卡片
        currentNeedDirection="left";

        while(blackhouseGame.maps[i].rightdoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[leftid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;

        blackhouseGame.currentrightmap=blackhouseGame.maps[i];
        blackhouseGame.currentrightmap.currentlayer=blackhouseGame.currentleftmap.currentlayer;  //设置其楼层
        blackhouseGame.currentrightmap.lastlocation=3;   //右边
        blackhouseGame.currentrightmap.isopen=true;   //设置为已翻开
        blackhouseGame.currentrightmap.x=blackhouseGame.currentleftmap.x-1;  //设置左边的x坐标
        blackhouseGame.currentrightmap.y=blackhouseGame.currentleftmap.y; //设置左边的y坐标

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentrightmap.currentlayer}_${blackhouseGame.currentleftmap.x-1}_${blackhouseGame.currentleftmap.y}",
                () => new coordinate(i,blackhouseGame.currentleftmap.x-1,blackhouseGame.currentleftmap.y,blackhouseGame.currentrightmap.currentlayer));
        setnearbyrooms(blackhouseGame,blackhouseGame.currentrightmap);    //设置新房间与四周的相互关系

        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentleftmap=blackhouseGame.maps[101];
        ischoose=true;
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;


        for(int i=0;i<x.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 50), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
          });
        }
      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
        setState(() {

        });
        return;
      }
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentrightmap.mapid;
    //blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer];
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.rightoffset.dx+ScreenUtil().setWidth(400);
    double newy=blackhouseGame.rightoffset.dy+ScreenUtil().setWidth(200);
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    x=(blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/10;
    y=(blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/x.abs();

    for(int i=0;i<x.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 50), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
      });
    }
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";

    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
        await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
        await comeIntoNewMap();
        return;
      }
      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }

    //----------------翻卡牌----------------------//
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    refreshPlayers();
    setState(() {

    });
  }
  //中间地图块的向左方向键按钮
  Widget middleroom_leftarrow()
  {
    return  Positioned(
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(210),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(450),
        child:Offstage(
          offstage: middleroom_leftarrow_offset,
          child: Container(
              child:ArrowButton(
                  direction: "left",
                  isopen: blackhouseGame.currentmiddlemap==null?false:blackhouseGame.currentmiddlemap.theleftroom!=0,
                  onTap:() async{
                      await middleroom_leftarrow_fun();
                  }
              )),
        ));
  }

  Future middleroom_leftarrow_fun() async{
    hideArrows();
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="left";

    //中间地图块的左边房间如果已经开放，则人物直接走过去，不刷新地图
    double x=(blackhouseGame.middleoffset.dx-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/10;
    double y=(blackhouseGame.middleoffset.dy+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/x.abs();
    bool isemitcard=blackhouseGame.currentmiddlemap.theleftroom==0;

    if(blackhouseGame.currentmiddlemap.theleftroom!=0)
    {
      for(int i=0;i<x.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 50), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
        });
      }

      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
    }
    //中间地图块的左边房间如果没有开放，房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在最左边的地图块
    else{
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentmiddlemap,"left");
      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);
        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;
        for(int i=0;i<x.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 50), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
          });
        }


        currentNeedDirection="left";

        while(blackhouseGame.maps[i].rightdoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[middleid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;

        blackhouseGame.currentleftmap=blackhouseGame.maps[i];
        blackhouseGame.currentleftmap.currentlayer=blackhouseGame.currentmiddlemap.currentlayer;  //设置其楼层
        blackhouseGame.currentleftmap.isopen=true;   //设置为已翻开
        blackhouseGame.currentleftmap.lastlocation=1;   //左边
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;

        blackhouseGame.currentleftmap.x=blackhouseGame.currentmiddlemap.x-1;  //设置左边的x坐标
        blackhouseGame.currentleftmap.y=blackhouseGame.currentmiddlemap.y; //设置左边的y坐标

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentmiddlemap.currentlayer}_${blackhouseGame.currentmiddlemap.x-1}_${blackhouseGame.currentmiddlemap.y}",
                () => new coordinate(i,blackhouseGame.currentmiddlemap.x-1,blackhouseGame.currentmiddlemap.y,blackhouseGame.currentmiddlemap.currentlayer));
        setnearbyrooms(blackhouseGame,blackhouseGame.currentleftmap);    //设置新房间与四周的相互关系

        ischoose=true;
      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
        setState(() {

        });
        return;
      }
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentleftmap.mapid;
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.leftoffset.dx+ScreenUtil().setWidth(400);
    double newy=blackhouseGame.leftoffset.dy+ScreenUtil().setWidth(200);
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    x=(blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/10;
    y=(blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/x.abs();

    for(int i=0;i<x.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 50), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
      });
    }

    blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await  call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
        await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
        await comeIntoNewMap();
        return;
      }
      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }

    //----------------翻卡牌----------------------//
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    refreshPlayers();
    setState(() {

    });
  }

  //右边地图块的向左方向键按钮
  Widget rightroom_leftarrow()
  {
    return Positioned(
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(210),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(840),
        child:Offstage(
          offstage: rightroom_leftarrow_offset,
          child: Container(
              child:ArrowButton(
                  direction: "left",
                  isopen: blackhouseGame.currentrightmap==null?false:blackhouseGame.currentrightmap.theleftroom!=0,
                  onTap:()  async{
                    await rightroom_leftarrow_fun();
                  }
              )),
        ));
  }

  Future rightroom_leftarrow_fun() async{
    hideArrows();
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="left";
    //右边地图块的左边房间如果已经开放，则人物直接走到中间，不刷新地图
    double x=(blackhouseGame.rightoffset.dx-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/10;
    double y=(blackhouseGame.rightoffset.dy+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/x.abs();

    bool isemitcard=blackhouseGame.currentrightmap.theleftroom==0;

    if(blackhouseGame.currentrightmap.theleftroom!=0)
    {
      for(int i=0;i<x.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 50), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
        });
      }
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
    }
    //右边地图块的左边房间如果没有开放，房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在最中间的地图块
    else
    {
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentrightmap,"left");
      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);
        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;
        for(int i=0;i<x.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 50), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
          });
        }
        //需要的卡牌向右对接
        currentNeedDirection="left";

        while(blackhouseGame.maps[i].rightdoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[rightid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;

        blackhouseGame.currentmiddlemap=blackhouseGame.maps[i];
        blackhouseGame.currentmiddlemap.currentlayer=blackhouseGame.currentrightmap.currentlayer;  //设置其楼层
        blackhouseGame.currentmiddlemap.isopen=true;   //设置为已翻开
        blackhouseGame.currentmiddlemap.lastlocation=2;

        blackhouseGame.currentmiddlemap.x=blackhouseGame.currentrightmap.x-1;  //设置左边的x坐标
        blackhouseGame.currentmiddlemap.y=blackhouseGame.currentrightmap.y; //设置左边的y坐标

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentrightmap.currentlayer}_${blackhouseGame.currentrightmap.x-1}_${blackhouseGame.currentrightmap.y}",
                () => new coordinate(i,blackhouseGame.currentrightmap.x-1,blackhouseGame.currentrightmap.y,blackhouseGame.currentrightmap.currentlayer));

        setnearbyrooms(blackhouseGame,blackhouseGame.currentmiddlemap);    //设置新房间与四周的相互关系

        ischoose=true;
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;


      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
        setState(() {

        });
        return;
      }
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentmiddlemap.mapid;
    // blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer];
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.middleoffset.dx+ScreenUtil().setWidth(400);
    double newy=blackhouseGame.middleoffset.dy+ScreenUtil().setWidth(200);
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    x=(blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/10;
    y=(blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/x.abs();

    for(int i=0;i<x.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 50), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
      });
    }
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";

    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
        await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
        await comeIntoNewMap();
        return;
      }
      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }
    //----------------翻卡牌----------------------//

    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();

    refreshPlayers();
    setState(() {

    });

  }

  //左边地图块的向右方向键按钮
  Widget leftroom_rightarrow()
  {
    return Positioned(
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(210),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(280),
        child:Offstage(
          offstage: leftroom_rightarrow_offset,
          child: Container(
              child:ArrowButton(
                  direction: "right",
                  isopen: blackhouseGame.currentleftmap==null?false:blackhouseGame.currentleftmap.therightroom!=0,
                  onTap:() async{
                   await leftroom_rightarrow_fun();
                  }
              )),
        ));
  }

  Future leftroom_rightarrow_fun() async{
    hideArrows();
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="right";

    //左边地图块的右边房间如果已经开放，则人物直接走到中间，不刷新地图
    double x=(blackhouseGame.leftoffset.dx+ScreenUtil().setWidth(400)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/10;
    double y=(blackhouseGame.leftoffset.dy+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/x.abs();
    bool isemitcard=blackhouseGame.currentleftmap.therightroom==0;
    if(blackhouseGame.currentleftmap.therightroom!=0)
    {
      for(int i=0;i<x.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 50), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
        });
      }
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
    }
    //左边地图块的右边房间如果没有开放，房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在中间的地图块
    else
    {
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentleftmap,"right");
      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);
        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;
        for(int i=0;i<x.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 50), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
          });
        }
        //需要的卡牌向右对接
        currentNeedDirection="right";

        while(blackhouseGame.maps[i].leftdoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[leftid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;

        blackhouseGame.currentmiddlemap=blackhouseGame.maps[i];
        blackhouseGame.currentmiddlemap.currentlayer=blackhouseGame.currentleftmap.currentlayer;  //设置其楼层
        blackhouseGame.currentmiddlemap.isopen=true;   //设置为已翻开
        blackhouseGame.currentmiddlemap.lastlocation=2;
        blackhouseGame.currentmiddlemap.theleftroom=blackhouseGame.currentleftmap.mapid;  //设置新房间左边的房间
        blackhouseGame.currentleftmap.therightroom=blackhouseGame.currentmiddlemap.mapid;   //设置原房间右边的房间为新翻出来的房间

        blackhouseGame.currentmiddlemap.x=blackhouseGame.currentleftmap.x+1;  //设置x坐标
        blackhouseGame.currentmiddlemap.y=blackhouseGame.currentleftmap.y; //设置y坐标

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentleftmap.currentlayer}_${blackhouseGame.currentleftmap.x+1}_${blackhouseGame.currentleftmap.y}",
                () => new coordinate(i,blackhouseGame.currentleftmap.x+1,blackhouseGame.currentleftmap.y,blackhouseGame.currentleftmap.currentlayer));
        setnearbyrooms(blackhouseGame,blackhouseGame.currentmiddlemap);    //设置新房间与四周的相互关系
        ischoose=true;
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;
      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
        setState(() {

        });
        return;
      }
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentmiddlemap.mapid;
    //blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer];
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.middleoffset.dx;
    double newy=blackhouseGame.middleoffset.dy+ScreenUtil().setWidth(200);
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    x=(blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/10;
    y=(blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/x.abs();

    for(int i=0;i<x.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 50), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
      });
    }
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";

    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await  call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
        await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
        await comeIntoNewMap();
        return;
      }
      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }

    //----------------翻卡牌----------------------//
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    refreshPlayers();
    setState(() {

    });
  }
  //中间地图块的向右方向键按钮
  Widget middleroom_rightarrow()
  {
    return  Positioned(
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(210),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(680),
        child:Offstage(
          offstage: middleroom_rightarrow_offset,
          child: Container(
              child:ArrowButton(
                  direction: "right",
                  isopen: blackhouseGame.currentmiddlemap==null?false:blackhouseGame.currentmiddlemap.therightroom!=0,

                  onTap:() async{
                     await middleroom_rightarrow_fun();
                  }
              )),
        ));
  }

  Future middleroom_rightarrow_fun() async{
    hideArrows();
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="right";
    //中间地图块的右边房间如果已经开放，则人物直接走过去，不刷新地图
    double x=(blackhouseGame.middleoffset.dx+ScreenUtil().setWidth(400)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/10;
    double y=(blackhouseGame.middleoffset.dy+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/x.abs();

    //是否触发抽卡
    bool isemitcard=blackhouseGame.currentmiddlemap.therightroom==0;

    if(blackhouseGame.currentmiddlemap.therightroom!=0)
    {
      for(int i=0;i<x.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 50), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
        });
      }
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
    }
    //中间地图块的左边房间如果没有开放，房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在最左边的地图块
    else{
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentmiddlemap,"right");
      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);
        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;
        for(int i=0;i<x.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 50), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
          });
        }
        //需要的卡牌向右对接
        currentNeedDirection="right";

        while(blackhouseGame.maps[i].leftdoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[middleid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;

        blackhouseGame.currentrightmap=blackhouseGame.maps[i];
        blackhouseGame.currentrightmap.currentlayer=blackhouseGame.currentmiddlemap.currentlayer;  //设置其楼层
        blackhouseGame.currentrightmap.isopen=true;   //设置为已翻开
        blackhouseGame.currentrightmap.lastlocation=3;
        blackhouseGame.currentrightmap.x=blackhouseGame.currentmiddlemap.x+1;  //设置x坐标
        blackhouseGame.currentrightmap.y=blackhouseGame.currentmiddlemap.y; //设置y坐标

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentmiddlemap.currentlayer}_${blackhouseGame.currentmiddlemap.x+1}_${blackhouseGame.currentmiddlemap.y}",
                () => new coordinate(i,blackhouseGame.currentmiddlemap.x+1,blackhouseGame.currentmiddlemap.y,blackhouseGame.currentmiddlemap.currentlayer));
        setnearbyrooms(blackhouseGame,blackhouseGame.currentrightmap);    //设置新房间与四周的相互关系
        ischoose=true;
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;
      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
        setState(() {

        });
        return;
      }
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentrightmap.mapid;
    //blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer];
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.rightoffset.dx;
    double newy=blackhouseGame.rightoffset.dy+ScreenUtil().setWidth(200);
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    x=(blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/10;
    y=(blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/x.abs();

    for(int i=0;i<x.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 50), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
      });
    }
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";

    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
        await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
        await comeIntoNewMap();
        return;
      }
      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }

    //----------------翻卡牌----------------------//
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    refreshPlayers();
    setState(() {

    });
  }
  //右边地图块的向右方向键按钮
  Widget rightroom_rightarrow()
  {
    return  Positioned(
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(210),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(1080),
        child:Offstage(
          offstage: rightroom_rightarrow_offset,
          child: Container(
              child:ArrowButton(
                  direction: "right",
                  isopen: blackhouseGame.currentrightmap==null?false:blackhouseGame.currentrightmap.therightroom!=0,
                  onTap:() async{
                   await rightroom_rightarrow_fun();
                  }
              )),
        ));
  }

  Future rightroom_rightarrow_fun() async{
    hideArrows();
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="right";

    //如果右边地图块右边的房间号不为0，即已经探索过了，则把其右边的房间放置在地图块的最左边，并展开这个房间右边的两个房间
    //如果右边的两个房间为空的，就用黑色块补齐
    double x=(blackhouseGame.rightoffset.dx+ScreenUtil().setWidth(400)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/10;
    double y=(blackhouseGame.rightoffset.dy+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/x.abs();
    bool isemitcard=blackhouseGame.currentrightmap.therightroom==0;

    if(blackhouseGame.currentrightmap.therightroom!=0)
    {
      for(int i=0;i<x.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 50), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
        });
      }
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
      blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentrightmap.therightroom];
      if(blackhouseGame.currentleftmap.therightroom!=0)
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentleftmap.therightroom];
        if(blackhouseGame.currentmiddlemap.therightroom!=0)
        {
          blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.therightroom];
        }
        else blackhouseGame.currentrightmap=blackhouseGame.maps[101];
      }
      else
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentrightmap=blackhouseGame.maps[101];
      };
    }
    //如果右边房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在地图块的最右边
    //右边的两个房间为空的，就用黑色块补齐
    else{
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentrightmap,"right");
      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);
        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;
        for(int i=0;i<x.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 50), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
          });
        }

        //需要的卡牌向右对接
        currentNeedDirection="right";

        while(blackhouseGame.maps[i].leftdoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[rightid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;

        blackhouseGame.currentleftmap=blackhouseGame.maps[i];
        blackhouseGame.currentleftmap.currentlayer=blackhouseGame.currentrightmap.currentlayer;  //设置其楼层
        blackhouseGame.currentleftmap.isopen=true;   //设置为已翻开
        blackhouseGame.currentleftmap.lastlocation=1;

        blackhouseGame.currentleftmap.x=blackhouseGame.currentrightmap.x+1;  //设置x坐标
        blackhouseGame.currentleftmap.y=blackhouseGame.currentrightmap.y; //设置y坐标

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentrightmap.currentlayer}_${blackhouseGame.currentrightmap.x+1}_${blackhouseGame.currentrightmap.y}",
                () => new coordinate(i,blackhouseGame.currentrightmap.x+1,blackhouseGame.currentrightmap.y,blackhouseGame.currentrightmap.currentlayer));
        setnearbyrooms(blackhouseGame,blackhouseGame.currentleftmap);    //设置新房间与四周的相互关系

        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentrightmap=blackhouseGame.maps[101];
        ischoose=true;
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;
      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
        setState(() {

        });
        return;
      }
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentleftmap.mapid;
    //blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer];
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.leftoffset.dx;
    double newy=blackhouseGame.leftoffset.dy+ScreenUtil().setWidth(200);
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    x=(blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/10;
    y=(blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/x.abs();
    for(int i=0;i<x.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 50), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x/x.abs()*10,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y);
      });
    }
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";

    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
        await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
        await comeIntoNewMap();
        return;
      }
      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }

    //----------------翻卡牌----------------------//
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    refreshPlayers();
    setState(() {

    });
  }
  //左边地图块的向上方向键按钮
  Widget leftroom_uparrow()
  {
    return Positioned(
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(100),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(180),
        child:Offstage(
          offstage: leftroom_uparrow_offset,
          child: Container(
              child:ArrowButton(
                  direction: "up",
                  isopen: blackhouseGame.currentleftmap==null?false:blackhouseGame.currentleftmap.theuproom!=0,
                  onTap:() async{
                   await leftroom_uparrow_fun();
                  }
              )),
        ));
  }

  Future leftroom_uparrow_fun() async{
    hideArrows();
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="back";

    //如果左边地图块上边的房间号不为0，即已经探索过了，则把其上边的房间放置在地图块的最左边，并展开这个房间右边的两个房间
    //如果右边的两个房间为空的，就用黑色块补齐
    double y=(blackhouseGame.leftoffset.dy-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/10;
    double x=(blackhouseGame.leftoffset.dx+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/y.abs();
    bool isemitcard=blackhouseGame.currentleftmap.theuproom==0;

    if(blackhouseGame.currentleftmap.theuproom!=0)
    {
      for(int i=0;i<y.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 80), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
        });
      }
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
      blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentleftmap.theuproom];
      if(blackhouseGame.currentleftmap.therightroom!=0)
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentleftmap.therightroom];
        if(blackhouseGame.currentmiddlemap.therightroom!=0)
        {
          blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.therightroom];
        }
        else blackhouseGame.currentrightmap=blackhouseGame.maps[101];
      }
      else
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentrightmap=blackhouseGame.maps[101];
      };
    }
    //如果左边上面房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在地图块的最左边
    //右边的两个房间为空的，就用黑色块补齐
    else{
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentleftmap,"up");
      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);
        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;
        for(int i=0;i<y.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 80), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
          });
        }

        //需要的卡牌向右对接
        currentNeedDirection="up";

        while(blackhouseGame.maps[i].downdoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[leftid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;


        //原地图信息先放中间地图上
        blackhouseGame.currentmiddlemap=blackhouseGame.currentleftmap;

        blackhouseGame.currentleftmap=blackhouseGame.maps[i];
        blackhouseGame.currentleftmap.currentlayer=blackhouseGame.currentmiddlemap.currentlayer;  //设置其楼层
        blackhouseGame.currentleftmap.isopen=true;   //设置为已翻开
        blackhouseGame.currentleftmap.lastlocation=1;


        blackhouseGame.currentleftmap.x=blackhouseGame.currentmiddlemap.x;  //设置x坐标
        blackhouseGame.currentleftmap.y=blackhouseGame.currentmiddlemap.y-1; //设置y坐标,屏幕坐标系，向上小些

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentmiddlemap.currentlayer}_${blackhouseGame.currentmiddlemap.x}_${blackhouseGame.currentmiddlemap.y-1}",
                () => new coordinate(i,blackhouseGame.currentmiddlemap.x,blackhouseGame.currentmiddlemap.y-1,blackhouseGame.currentmiddlemap.currentlayer));
        setnearbyrooms(blackhouseGame,blackhouseGame.currentleftmap);    //设置新房间与四周的相互关系

        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentrightmap=blackhouseGame.maps[101];
        ischoose=true;
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;


      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
        setState(() {

        });
        return;
      }
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentleftmap.mapid;
    //blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer];
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.leftoffset.dx+ScreenUtil().setWidth(200);
    double newy=blackhouseGame.leftoffset.dy+ScreenUtil().setWidth(300);
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    y=(blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/10;
    x=(blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/y.abs();

    for(int i=0;i<y.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 80), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
      });
    }
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";

    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
        await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
        await comeIntoNewMap();
        return;
      }
      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }

    //----------------翻卡牌----------------------//
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    refreshPlayers();
    setState(() {

    });
  }
  //中间地图块的向上方向键按钮
  Widget middleroom_uparrow()
  {
     return Positioned(
         top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(100),
         left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(580),
         child:Offstage(
           offstage: middleroom_uparrow_offset,
           child: Container(
               child:ArrowButton(
                   direction: "up",
                   isopen: blackhouseGame.currentmiddlemap==null?false:blackhouseGame.currentmiddlemap.theuproom!=0,
                   onTap:() async{
                     await middleroom_uparrow_fun();

                   }
               )),
         ));
  }
  Future middleroom_uparrow_fun() async{
    hideArrows();
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="back";

    //如果中间地图块上边的房间号不为0，即已经探索过了，则把其上边的房间放置在地图块的最中，并展开这个房间左右边的两个房间
    //如果左右边的两个房间为空的，就用黑色块补齐
    double y=(blackhouseGame.middleoffset.dy-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/10;
    double x=(blackhouseGame.middleoffset.dx+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/y.abs();
    bool isemitcard=blackhouseGame.currentmiddlemap.theuproom==0;

    if(blackhouseGame.currentmiddlemap.theuproom!=0)
    {
      for(int i=0;i<y.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 80), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
        });
      }
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
      blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theuproom];
      if(blackhouseGame.currentmiddlemap.theleftroom!=0)
      {
        blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theleftroom];
      }
      else blackhouseGame.currentleftmap=blackhouseGame.maps[100];
      if(blackhouseGame.currentmiddlemap.therightroom!=0)
      {
        blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.therightroom];
      }
      else blackhouseGame.currentrightmap=blackhouseGame.maps[101];
    }
    //如果中间上面房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在地图块的最中间
    //左右边的两个房间为空的，就用黑色块补齐
    else{
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentmiddlemap,"up");
      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);
        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;
        for(int i=0;i<y.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 80), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
          });
        }

        //需要的卡牌向右对接
        currentNeedDirection="up";

        while(blackhouseGame.maps[i].downdoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[middleid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;

        //把原先的中间模块先临时放到左边模块,后续方便赋值
        blackhouseGame.currentleftmap=blackhouseGame.currentmiddlemap;

        blackhouseGame.currentmiddlemap=blackhouseGame.maps[i];
        blackhouseGame.currentmiddlemap.currentlayer=blackhouseGame.currentleftmap.currentlayer;  //设置其楼层
        blackhouseGame.currentmiddlemap.isopen=true;   //设置为已翻开
        blackhouseGame.currentmiddlemap.lastlocation=2;

        blackhouseGame.currentmiddlemap.x=blackhouseGame.currentleftmap.x;  //设置x坐标
        blackhouseGame.currentmiddlemap.y=blackhouseGame.currentleftmap.y-1; //设置y坐标

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentleftmap.currentlayer}_${blackhouseGame.currentleftmap.x}_${blackhouseGame.currentleftmap.y-1}",
                () => new coordinate(i,blackhouseGame.currentleftmap.x,blackhouseGame.currentleftmap.y-1,blackhouseGame.currentleftmap.currentlayer));
        setnearbyrooms(blackhouseGame,blackhouseGame.currentmiddlemap);    //设置新房间与四周的相互关系

        blackhouseGame.currentrightmap=blackhouseGame.maps[100];
        blackhouseGame.currentleftmap=blackhouseGame.maps[101];
        ischoose=true;
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;

      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
        setState(() {

        });
        return;
      }
    }
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentmiddlemap.mapid;
    //blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer];
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.middleoffset.dx+ScreenUtil().setWidth(200);
    double newy=blackhouseGame.middleoffset.dy+ScreenUtil().setWidth(300);
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    y=(blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/10;
    x=(blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/y.abs();
    for(int i=0;i<y.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 80), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
      });
    }
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
        await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
        await comeIntoNewMap();
        return;
      }
      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }

    //----------------翻卡牌----------------------//
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    refreshPlayers();
    setState(() {

    });
  }

  //右边地图块的向上方向键按钮
  Widget rightroom_uparrow()
  {
      return  Positioned(
          top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(100),
          left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(980),
          child:Offstage(
            offstage: rightroom_uparrow_offset,
            child: Container(
                child:ArrowButton(
                    direction: "up",
                    isopen: blackhouseGame.currentrightmap==null?false:blackhouseGame.currentrightmap.theuproom!=0,
                    onTap:() async{
                      await rightroom_uparrow_fun();

                    }
                )),
          ));
  }

  Future rightroom_uparrow_fun() async{
    hideArrows();

    await ItemFunction.items01_effect01(context,8,blackhouseGame);
    await ItemFunction.items01_effect02(context,blackhouseGame);

    blackhouseGame.persons[blackhouseGame.currentplayer].direct="back";

    //如果右边地图块上边的房间号不为0，即已经探索过了，则把其上边的房间放置在地图块的最右边，并展开这个房间左边的两个房间
    //如果左边的两个房间为空的，就用黑色块补齐
    double y=(blackhouseGame.rightoffset.dy-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/10;

    double x=(blackhouseGame.rightoffset.dx+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/y.abs();
    bool isemitcard=blackhouseGame.currentrightmap.theuproom==0;

    if(blackhouseGame.currentrightmap.theuproom!=0)
    {
      for(int i=0;i<y.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 80), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
        });
      }
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
      blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentrightmap.theuproom];
      if(blackhouseGame.currentrightmap.theleftroom!=0)
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentrightmap.theleftroom];
        if(blackhouseGame.currentmiddlemap.theleftroom!=0)
        {
          blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theleftroom];
        }
        else blackhouseGame.currentleftmap=blackhouseGame.maps[101];
      }
      else
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentleftmap=blackhouseGame.maps[101];
      };
    }
    //如果右边上边房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在地图块的最右边
    //右边的两个房间为空的，就用黑色块补齐
    else{
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentrightmap,"up");

      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);
        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;
        for(int i=0;i<y.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 80), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
          });
        }

        //需要的卡牌向右对接
        currentNeedDirection="up";

        while(blackhouseGame.maps[i].downdoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[rightid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;

        //房间信息临时存在中间地图上
        blackhouseGame.currentmiddlemap=blackhouseGame.currentrightmap;

        blackhouseGame.currentrightmap=blackhouseGame.maps[i];
        blackhouseGame.currentrightmap.currentlayer=blackhouseGame.currentmiddlemap.currentlayer;  //设置其楼层
        blackhouseGame.currentrightmap.isopen=true;   //设置为已翻开
        blackhouseGame.currentrightmap.lastlocation=3;

        blackhouseGame.currentrightmap.x=blackhouseGame.currentmiddlemap.x;  //设置x坐标
        blackhouseGame.currentrightmap.y=blackhouseGame.currentmiddlemap.y-1; //设置y坐标

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentmiddlemap.currentlayer}_${blackhouseGame.currentmiddlemap.x}_${blackhouseGame.currentmiddlemap.y-1}",
                () => new coordinate(i,blackhouseGame.currentmiddlemap.x,blackhouseGame.currentmiddlemap.y-1,blackhouseGame.currentmiddlemap.currentlayer));
        setnearbyrooms(blackhouseGame,blackhouseGame.currentrightmap);    //设置新房间与四周的相互关系


        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentleftmap=blackhouseGame.maps[101];
        ischoose=true;
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;
      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";
        setState(() {

        });
        return;
      }
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentrightmap.mapid;
    //blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer];
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.rightoffset.dx+ScreenUtil().setWidth(200);
    double newy=blackhouseGame.rightoffset.dy+ScreenUtil().setWidth(300);
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    y=(blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/10;
    x=(blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/y.abs();
    for(int i=0;i<y.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 80), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
      });
    }
    blackhouseGame.persons[blackhouseGame.currentplayer].direct="front";

    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
        await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
        await comeIntoNewMap();
        return;
      }
      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }

    //----------------翻卡牌----------------------//
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    refreshPlayers();
    setState(() {

    });
  }

  //左边地图块的向下方向键按钮
  Widget lefttroom_downarrow()
  {
    return  Positioned(
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(310),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(180),
        child:Offstage(
          offstage: leftroom_downarrow_offset,
          child: Container(
              child:ArrowButton(
                  direction: "down",
                  isopen: blackhouseGame.currentleftmap==null?false:blackhouseGame.currentleftmap.thedownroom!=0,
                  onTap:() async{
                    await leftroom_downarrow_fun();

                  }
              )),
        ));
  }

  Future leftroom_downarrow_fun() async{
    hideArrows();
    //如果左边地图块下边的房间号不为0，即已经探索过了，则把其下边的房间放置在地图块的最左边，并展开这个房间右边的两个房间
    //如果右边的两个房间为空的，就用黑色块补齐
    double y=(blackhouseGame.leftoffset.dy+ScreenUtil().setWidth(300)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/10;

    double x=(blackhouseGame.leftoffset.dx+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/y.abs();
    bool isemitcard=blackhouseGame.currentleftmap.thedownroom==0;

    if(blackhouseGame.currentleftmap.thedownroom!=0)
    {
      for(int i=0;i<y.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 80), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
        });
      }
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
      blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentleftmap.thedownroom];
      if(blackhouseGame.currentleftmap.therightroom!=0)
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentleftmap.therightroom];
        if(blackhouseGame.currentmiddlemap.therightroom!=0)
        {
          blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.therightroom];
        }
        else blackhouseGame.currentrightmap=blackhouseGame.maps[101];
      }
      else
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentrightmap=blackhouseGame.maps[101];
      };
    }
    //如果左边下面房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在地图块的最左边
    //右边的两个房间为空的，就用黑色块补齐
    else{
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentleftmap,"down");

      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);
        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;
        for(int i=0;i<y.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 80), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
          });
        }

        //需要的卡牌向右对接
        currentNeedDirection="down";

        while(blackhouseGame.maps[i].updoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[leftid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;

        //临时用中间地图块存信息
        blackhouseGame.currentmiddlemap=blackhouseGame.currentleftmap;
        blackhouseGame.currentleftmap=blackhouseGame.maps[i];
        blackhouseGame.currentleftmap.currentlayer=blackhouseGame.currentmiddlemap.currentlayer;  //设置其楼层
        blackhouseGame.currentleftmap.isopen=true;   //设置为已翻开
        blackhouseGame.currentleftmap.lastlocation=1;


        blackhouseGame.currentleftmap.x=blackhouseGame.currentmiddlemap.x;  //设置x坐标
        blackhouseGame.currentleftmap.y=blackhouseGame.currentmiddlemap.y+1; //设置y坐标

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentmiddlemap.currentlayer}_${blackhouseGame.currentmiddlemap.x}_${blackhouseGame.currentmiddlemap.y+1}",
                () => new coordinate(i,blackhouseGame.currentmiddlemap.x,blackhouseGame.currentmiddlemap.y+1,blackhouseGame.currentmiddlemap.currentlayer));
        setnearbyrooms(blackhouseGame,blackhouseGame.currentleftmap);    //设置新房间与四周的相互关系

        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentrightmap=blackhouseGame.maps[101];
        ischoose=true;
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;
      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        setState(() {

        });
        return;
      }
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentleftmap.mapid;
    //blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer];
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.leftoffset.dx+ScreenUtil().setWidth(200);
    double newy=blackhouseGame.leftoffset.dy;
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    y=(blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/10;
    x=(blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/y.abs();
    for(int i=0;i<y.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 80), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
      });
    }
    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
       await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
        await comeIntoNewMap();
        return;
      }
      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }

    //----------------翻卡牌----------------------//
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    refreshPlayers();
    setState(() {

    });
  }
  //中间地图块的向下方向键按钮
  Widget middletroom_downarrow()
  {
   return Positioned(
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(310),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(580),
        child:Offstage(
          offstage: middleroom_downarrow_offset,
          child: Container(
              child:ArrowButton(
                  direction: "down",
                  isopen:blackhouseGame.currentmiddlemap==null?false: blackhouseGame.currentmiddlemap.thedownroom!=0,
                  onTap:() async{
                    await middletroom_downarrow_fun();

                  }
              )),
        ));
  }

  Future middletroom_downarrow_fun() async{
    hideArrows();
    //如果中间地图块下边的房间号不为0，即已经探索过了，则把其下边的房间放置在地图块的最中，并展开这个房间左右边的两个房间
    //如果左右边的两个房间为空的，就用黑色块补齐
    double y=(blackhouseGame.middleoffset.dy+ScreenUtil().setWidth(300)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/10;
    double x=(blackhouseGame.middleoffset.dx+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/y.abs();
    bool isemitcard=blackhouseGame.currentmiddlemap.thedownroom==0;

    if(blackhouseGame.currentmiddlemap.thedownroom!=0)
    {
      for(int i=0;i<y.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 80), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
        });
      }
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;

      blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.thedownroom];
      if(blackhouseGame.currentmiddlemap.theleftroom!=0)
      {
        blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theleftroom];
      }
      else blackhouseGame.currentleftmap=blackhouseGame.maps[100];
      if(blackhouseGame.currentmiddlemap.therightroom!=0)
      {
        blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.therightroom];
      }
      else blackhouseGame.currentrightmap=blackhouseGame.maps[101];
    }
    //如果中间上面房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在地图块的最中间
    //左右边的两个房间为空的，就用黑色块补齐
    else{
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentmiddlemap,"down");
      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);
        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;
        for(int i=0;i<y.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 80), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
          });
        }

        //需要的卡牌向右对接
        currentNeedDirection="down";

        while(blackhouseGame.maps[i].updoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[middleid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;

        //把原先的中间模块先临时放到左边模块,后续方便赋值
        blackhouseGame.currentleftmap=blackhouseGame.currentmiddlemap;

        blackhouseGame.currentmiddlemap=blackhouseGame.maps[i];
        blackhouseGame.currentmiddlemap.currentlayer=blackhouseGame.currentleftmap.currentlayer;  //设置其楼层
        blackhouseGame.currentmiddlemap.isopen=true;   //设置为已翻开
        blackhouseGame.currentmiddlemap.lastlocation=2;


        blackhouseGame.currentmiddlemap.x=blackhouseGame.currentleftmap.x;  //设置x坐标
        blackhouseGame.currentmiddlemap.y=blackhouseGame.currentleftmap.y+1; //设置y坐标

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentleftmap.currentlayer}_${blackhouseGame.currentleftmap.x}_${blackhouseGame.currentleftmap.y+1}",
                () => new coordinate(i,blackhouseGame.currentleftmap.x,blackhouseGame.currentleftmap.y+1,blackhouseGame.currentleftmap.currentlayer));
        setnearbyrooms(blackhouseGame,blackhouseGame.currentmiddlemap);    //设置新房间与四周的相互关系

        blackhouseGame.currentrightmap=blackhouseGame.maps[100];
        blackhouseGame.currentleftmap=blackhouseGame.maps[101];
        ischoose=true;
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;
      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        setState(() {

        });
        return;
      }
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentmiddlemap.mapid;
    //blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer];
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.middleoffset.dx+ScreenUtil().setWidth(200);
    double newy=blackhouseGame.middleoffset.dy;
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    y=(blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/10;

    x=(blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/y.abs();
    for(int i=0;i<y.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 80), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
      });
    }

    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
        await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
          await comeIntoNewMap();
          return;
        }

      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }

    //----------------翻卡牌----------------------//
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    refreshPlayers();
    setState(() {

    });
  }
  //右边地图块的向下方向键按钮
  Widget righttroom_downarrow()
  {
      return  Positioned(
          top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(310),
          left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(980),
          child:Offstage(
            offstage: rightroom_downarrow_offset,
            child: Container(
                child:ArrowButton(
                    direction: "down",
                    isopen: blackhouseGame.currentrightmap==null?false:blackhouseGame.currentrightmap.thedownroom!=0,
                    onTap:() async{
                      await righttroom_downarrow_fun();

                    }
                )),
          ));
  }
  Future righttroom_downarrow_fun() async{
    hideArrows();
    //如果右边地图块下边的房间号不为0，即已经探索过了，则把其下边的房间放置在地图块的最右边，并展开这个房间左边的两个房间
    //如果左边的两个房间为空的，就用黑色块补齐
    double y=(blackhouseGame.rightoffset.dy+ScreenUtil().setWidth(300)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dy)/10;
    double x=(blackhouseGame.rightoffset.dx+ScreenUtil().setWidth(200)-blackhouseGame.persons[blackhouseGame.currentplayer].position.dx)/y.abs();

    bool isemitcard=blackhouseGame.currentrightmap.thedownroom==0;

    if(blackhouseGame.currentrightmap.thedownroom!=0)
    {
      for(int i=0;i<y.abs();i++)
      {
        await Future.delayed(const Duration(milliseconds: 80), () {
          blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
        });
      }
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
      blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentrightmap.thedownroom];
      if(blackhouseGame.currentrightmap.theleftroom!=0)
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentrightmap.theleftroom];
        if(blackhouseGame.currentmiddlemap.theleftroom!=0)
        {
          blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theleftroom];
        }
        else blackhouseGame.currentleftmap=blackhouseGame.maps[101];
      }
      else
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentleftmap=blackhouseGame.maps[101];
      };
    }
    //如果右边下边房间号为0，即表示没有探索过，则随机抽取和这个房间属性currentlayer相匹配的房间，放置在地图块的最右边
    //右边的两个房间为空的，就用黑色块补齐
    else{
      bool ischoose=false;
      //随机抽取可用的房间卡
      List<int> roomslist=isDoorMacthedMaps(blackhouseGame,blackhouseGame.currentrightmap,"down");
      if(roomslist.length>0)
      {
        //随机抽取可用的房间卡
        int i=chooseRoom(roomslist);
        if(ischooseroom==0&&ischooseRoomDoor==0) {
          String isok = await chooseEnterUnknowRoom(context);
          if (isok != "ok") {
            setState(() {

            });
            return;
          }
        }
        //提前清掉，避免下次继续进入循环
        choosedMapID=0;
        chooseMapDoor=0;
        for(int i=0;i<y.abs();i++)
        {
          await Future.delayed(const Duration(milliseconds: 80), () {
            blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
          });
        }

        //需要的卡牌向右对接
        currentNeedDirection="down";

        while(blackhouseGame.maps[i].updoor==0) {
          turn90(blackhouseGame,blackhouseGame.maps[i]);
        }

        //右边有门，则直接弹窗展示到选择地图框里
        blackhouseGame.currenchoosemap=blackhouseGame.maps[i];
        //保存现有左中右地图块的信息
        int leftid=blackhouseGame.currentleftmap.mapid;
        int middleid=blackhouseGame.currentmiddlemap.mapid;
        int rightid=blackhouseGame.currentrightmap.mapid;
        blackhouseGame.currentleftmap=null;
        blackhouseGame.currentmiddlemap=null;
        blackhouseGame.currentrightmap=null;
        setState(() {

        });
        await rotateMapblockDialog(context,blackhouseGame.maps[rightid]);
        blackhouseGame.currentleftmap=blackhouseGame.maps[leftid];
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[middleid];
        blackhouseGame.currentrightmap=blackhouseGame.maps[rightid];
        blackhouseGame.currenchoosemap=null;

        //临时用中间地图块存信息
        blackhouseGame.currentmiddlemap=blackhouseGame.currentrightmap;
        blackhouseGame.currentrightmap=blackhouseGame.maps[i];
        blackhouseGame.currentrightmap.currentlayer=blackhouseGame.currentmiddlemap.currentlayer;  //设置其楼层
        blackhouseGame.currentrightmap.isopen=true;   //设置为已翻开
        blackhouseGame.currentrightmap.lastlocation=3;


        blackhouseGame.currentrightmap.x=blackhouseGame.currentmiddlemap.x;  //设置x坐标
        blackhouseGame.currentrightmap.y=blackhouseGame.currentmiddlemap.y+1; //设置y坐标

        blackhouseGame.mapcoordinate.putIfAbsent("${blackhouseGame.currentmiddlemap.currentlayer}_${blackhouseGame.currentmiddlemap.x}_${blackhouseGame.currentmiddlemap.y+1}",
                () => new coordinate(i,blackhouseGame.currentmiddlemap.x,blackhouseGame.currentmiddlemap.y+1,blackhouseGame.currentmiddlemap.currentlayer));
        setnearbyrooms(blackhouseGame,blackhouseGame.currentrightmap);    //设置新房间与四周的相互关系

        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentleftmap=blackhouseGame.maps[101];
        ischoose=true;
        blackhouseGame.persons[blackhouseGame.currentplayer].step=0;
      }
      if(!ischoose)
      {
        print("没有可放置的地图");
        setState(() {

        });
        return;
      }
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentrightmap.mapid;
    //blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer];
    changeScence();
    refreshPlayers();
    double newx=blackhouseGame.rightoffset.dx+ScreenUtil().setWidth(200);
    double newy=blackhouseGame.rightoffset.dy;
    blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(newx,newy);
    y=(blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer].dy-newy)/10;
    x=(blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer].dx-newx)/y.abs();
    for(int i=0;i<y.abs();i++)
    {
      await Future.delayed(const Duration(milliseconds: 80), () {
        blackhouseGame.persons[blackhouseGame.currentplayer].position=Offset(blackhouseGame.persons[blackhouseGame.currentplayer].position.dx +x,blackhouseGame.persons[blackhouseGame.currentplayer].position.dy+y/y.abs()*10);
      });
    }
    refreshPlayers();
    setState(() {

    });
    //----------------翻卡牌----------------------//
    if(isemitcard) {
      hideArrows();
      eventcardId=0;
      if(Events.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Events.triggerTheEvent(context, blackhouseGame);
      if(eventcardId==39)
        await call();
      if(eventcardId==44)
        await wheresThis();
      if(eventcardId==55)
        await eyesOnTheWall();
      if(choosedMapID!=0&&chooseMapDoor!=0) {
        await comeIntoNewMap();
        return;
      }

      if(Items.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Items.triggerTheItem(context, blackhouseGame);
      if(Omens.istriggerTheRoom(blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid,blackhouseGame))
        await Omens.triggerTheOmen(context, blackhouseGame);
      ishidearrows = false;
    }

    //----------------翻卡牌----------------------//
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    refreshPlayers();
    setState(() {

    });
  }

  //左边地图块的正中间方向键按钮
  Widget leftroom_middlearrow()
  {
    return Positioned(
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(200),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(180),
        child:Offstage(
          offstage: leftroom_middlearrow_offset,
          child: Container(
              child:MiddleArrowButton(
                  onTap:() async{
                    await leftroom_middlearrow_fun();

                  }
              )),
        ));
  }
  Future leftroom_middlearrow_fun() async{
    hideArrows();
    if(blackhouseGame.currentleftmap.themiddleroom!=0)
    {
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
      blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentleftmap.thedownroom];
      if(blackhouseGame.currentrightmap.theleftroom!=0)
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentrightmap.theleftroom];
        if(blackhouseGame.currentmiddlemap.theleftroom!=0)
        {
          blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theleftroom];
        }
        else blackhouseGame.currentleftmap=blackhouseGame.maps[101];
      }
      else
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentleftmap=blackhouseGame.maps[101];
      };
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentrightmap.mapid;
    blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.rightpersonoffsetmap[blackhouseGame.currentplayer];
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    setState(() {

    });
    refreshPlayers();
  }
  //中间地图块的正中间方向键按钮
  Widget middleroom_middlearrow()
  {
    return Positioned(
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(200),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(580),
        child:Offstage(
          offstage: middleroom_middlearrow_offset,
          child: Container(
              child:MiddleArrowButton(
                  onTap:() async{
                    await middleroom_middlearrow_fun();

                  }
              )),
        ));
  }
  Future middleroom_middlearrow_fun() async{
    hideArrows();
    if(blackhouseGame.currentmiddlemap.themiddleroom!=0)
    {
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;

      blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.themiddleroom];
      if(blackhouseGame.currentmiddlemap.theleftroom!=0)
      {
        blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theleftroom];
      }
      else blackhouseGame.currentleftmap=blackhouseGame.maps[100];
      if(blackhouseGame.currentmiddlemap.therightroom!=0)
      {
        blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.therightroom];
      }
      else blackhouseGame.currentrightmap=blackhouseGame.maps[101];
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentmiddlemap.mapid;
    blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.middlepersonoffsetmap[blackhouseGame.currentplayer];
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();
    setState(() {

    });
    refreshPlayers();
  }
  //右边地图块的向正中间向键按钮
  Widget rightroom_middlearrow()
  {
    return Positioned(
        top:  ScreenUtil().setHeight(750)/8+ScreenUtil().setHeight(200),
        left: (ScreenUtil().setWidth(1334)-ScreenUtil().setWidth(1200))/2+ScreenUtil().setWidth(980),
        child:Offstage(
          offstage: rightroom_middlearrow_offset,
          child: Container(
              child:MiddleArrowButton(
                  onTap:() async{
                    await rightroom_middlearrow_fun();
                  }
              )),
        ));
  }

  Future rightroom_middlearrow_fun() async{
    hideArrows();
    //如果右边地图块中间连接的房间号不为0，即已经探索过了，则把其连接的房间放置在地图块的最左边，并展开这个房间右边的两个房间
    //如果右边的两个房间为空的，就用黑色块补齐
    if(blackhouseGame.currentrightmap.themiddleroom!=0)
    {
      blackhouseGame.persons[blackhouseGame.currentplayer].step-=1;
      blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentrightmap.themiddleroom];
      if(blackhouseGame.currentleftmap.therightroom!=0)
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentleftmap.therightroom];
        if(blackhouseGame.currentmiddlemap.therightroom!=0)
        {
          blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.therightroom];
        }
        else blackhouseGame.currentrightmap=blackhouseGame.maps[101];
      }
      else
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentrightmap=blackhouseGame.maps[101];
      };
    }
    //移动人物位置
    blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=blackhouseGame.currentleftmap.mapid;
    blackhouseGame.persons[blackhouseGame.currentplayer].position=blackhouseGame.leftpersonoffsetmap[blackhouseGame.currentplayer];
    //计步完后切换用户
    if(blackhouseGame.persons[blackhouseGame.currentplayer].step==0)
      changePlayer();

    refreshPlayers();
    setState(() {

    });
  }
  //房间未探索提示
  Future chooseEnterUnknowRoom(BuildContext context) async{
    var result = await showDialog(
        barrierDismissible:false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('该房间还未被探索，是否抽取地图进行探索'),
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


  //小地图弹窗
  Widget  littemapWidget()
  {
    return  Container(
        width: 200,
        alignment: Alignment.topLeft,
        height: 200,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            maplayer(1,"地下室"),
            maplayer(2,"地面"),
            maplayer(3,"楼上"),
            maplayer(4,"顶楼"),
            rotateconfirm("关闭"),  //确认
          ],
        )
    );
  }


  //展示小地图弹窗
  Future showlittlemapDialog(BuildContext context) async{
    var result = await  showGeneralDialog(
        barrierColor: Colors.transparent,
        context: context,
        barrierDismissible:false,
        barrierLabel: '小地图',
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context,
            Animation<double> animation,Animation<double> secondaryAnimation)
        {
          return littemapWidget();
        });
    return result;
  }

  //地下室小地图
  Widget maplayer(int layer,String name)
  {
    return Container(
      width: ScreenUtil().setWidth(100),
      height: ScreenUtil().setHeight(60),
      //margin: EdgeInsets.all(ScreenUtil().setHeight(60)),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assets/images/menu/button.png"),
            fit: BoxFit.fill),
      ),
      alignment: Alignment.center,
      child: FlatButton(
        //minWidth: 300,
        //height: 60,
        onPressed: ()
        {
          blackhouseGame.showlayer=layer;
          //refreshlittlemapPlayers();
        },
        child: Text(name),
        color: Colors.transparent,
      ),
    );
  }


  //翻转卡牌窗口控件,传入抽出的卡牌和门的方向
  Widget  rotateMapblockWidget(Mapblock oldmap)
  {
    //先隐藏人物单位
    for(int i=1;i<=blackhouseGame.playernum;i++)
    {
        blackhouseGame.currentpersons[i]=null;
    }
    return  Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              rotatetoleft(oldmap),  //向左转
              rotatetoright(oldmap),  //向右转
              rotateconfirm("确认放置"),  //确认
           ],
           )
        );
  }


  Future rotateMapblockDialog(BuildContext context,Mapblock oldmap) async{
    var result = await  showGeneralDialog(
        barrierColor: Colors.transparent,
        context: context,
        barrierDismissible:true,
        barrierLabel: '请选择房间的方向',
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context,
            Animation<double> animation,Animation<double> secondaryAnimation)
        {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body:rotateMapblockWidget(oldmap));
        });
    return result;
  }

  Widget rotatetoleft(Mapblock oldmap)
  {
    return Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setHeight(40),
      margin: EdgeInsets.all(ScreenUtil().setHeight(60)),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assets/images/menu/button.png"),
            fit: BoxFit.fill),
      ),
      alignment: Alignment.center,
      child: FlatButton(
        //minWidth: 300,
        //height: 60,
        onPressed: ()
        {
          if(currentNeedDirection=="left")
          {
              turnleft_270(blackhouseGame,);
            while(!isleftmatch(blackhouseGame,oldmap,blackhouseGame.currenchoosemap))
              turnleft_270(blackhouseGame,);
          }
          else  if(currentNeedDirection=="right")
          {
              turnleft_270(blackhouseGame,);
            while(!isrightmatch(blackhouseGame,oldmap,blackhouseGame.currenchoosemap))
              turnleft_270(blackhouseGame,);
          }
          else  if(currentNeedDirection=="down")
          {
            turnleft_270(blackhouseGame,);
            while(!isdownmatch(blackhouseGame,oldmap,blackhouseGame.currenchoosemap))
              turnleft_270(blackhouseGame,);
          }
          else  if(currentNeedDirection=="up")
          {
            turnleft_270(blackhouseGame,);
            while(!isupmatch(blackhouseGame,oldmap,blackhouseGame.currenchoosemap))
            turnleft_270(blackhouseGame,);
          }
          },
        child: Text("向左旋转"),
        color: Colors.transparent,
      ),
    );
  }


  Widget rotatetoright(Mapblock oldmap)
  {
    return Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setHeight(40),
      margin: EdgeInsets.all(ScreenUtil().setHeight(60)),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assets/images/menu/button.png"),
            fit: BoxFit.fill),
      ),
      alignment: Alignment.center,
      child: FlatButton(
        //minWidth: 300,
        //height: 60,
        onPressed: ()
        {
          if(currentNeedDirection=="left")
          {
            turnright_90(blackhouseGame,);
            while(!isleftmatch(blackhouseGame,oldmap,blackhouseGame.currenchoosemap))
              turnright_90(blackhouseGame,);
          }
          else  if(currentNeedDirection=="right")
          {
            turnright_90(blackhouseGame,);
            while(!isrightmatch(blackhouseGame,oldmap,blackhouseGame.currenchoosemap))
              turnright_90(blackhouseGame);
          }

          if(currentNeedDirection=="up")
          {
            turnright_90(blackhouseGame);
            while(!isupmatch(blackhouseGame,oldmap,blackhouseGame.currenchoosemap))
              turnright_90(blackhouseGame);
          }
          else  if(currentNeedDirection=="down")
          {
            turnright_90(blackhouseGame);
            while(!isdownmatch(blackhouseGame,oldmap,blackhouseGame.currenchoosemap))
              turnright_90(blackhouseGame);
          }
        },
        child: Text("向右旋转"),
        color: Colors.transparent,
      ),
    );
  }



  Widget rotateconfirm(String str)
  {
    return Container(
      width: ScreenUtil().setWidth(100),
      height: ScreenUtil().setHeight(40),
      margin: EdgeInsets.all(ScreenUtil().setHeight(60)),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assets/images/menu/button.png"),
            fit: BoxFit.fill),
      ),
      alignment: Alignment.center,
      child: FlatButton(
        //minWidth: 300,
        //height: 60,
        onPressed: ()
        {
          Navigator.of(context).pop('ok');
        },
        child: Text(str),
        color: Colors.transparent,
      ),
    );
  }

  void hideArrows()
  {
    leftroom_leftarrow_offset=true;
    leftroom_uparrow_offset=true;
    leftroom_rightarrow_offset=true;
    leftroom_downarrow_offset=true;
    leftroom_middlearrow_offset=true;
    middleroom_leftarrow_offset=true;
    middleroom_uparrow_offset=true;
    middleroom_rightarrow_offset=true;
    middleroom_downarrow_offset=true;
    middleroom_middlearrow_offset=true;
    rightroom_leftarrow_offset=true;
    rightroom_uparrow_offset=true;
    rightroom_rightarrow_offset=true;
    rightroom_downarrow_offset=true;
    rightroom_middlearrow_offset=true;
    ishidearrows=true;
    setState(() {

    });
  }

  void refreshArrows()
  {
    //如果是隐藏箭头，则直接返回
    if(ishidearrows)
      {
        ishidearrows=false;
        return;
      }
    //左边地图块的门可见属性设置
    if(blackhouseGame.currentleftmap!=null)
    {
    blackhouseGame.currentleftmap.leftdoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentleftmap.mapid?leftroom_leftarrow_offset=false:leftroom_leftarrow_offset=true;
    blackhouseGame.currentleftmap.updoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentleftmap.mapid?leftroom_uparrow_offset=false:leftroom_uparrow_offset=true;
    blackhouseGame.currentleftmap.rightdoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentleftmap.mapid?leftroom_rightarrow_offset=false:leftroom_rightarrow_offset=true;
    blackhouseGame.currentleftmap.downdoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentleftmap.mapid?leftroom_downarrow_offset=false:leftroom_downarrow_offset=true;
    blackhouseGame.currentleftmap.themiddleroom!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentleftmap.mapid?leftroom_middlearrow_offset=false:leftroom_middlearrow_offset=true;
    }
    else
      {
        leftroom_leftarrow_offset=true;
        leftroom_uparrow_offset=true;
        leftroom_rightarrow_offset=true;
        leftroom_downarrow_offset=true;
        leftroom_middlearrow_offset=true;
      }

    //中间地图块的门可见属性设置
    if(blackhouseGame.currentmiddlemap!=null)
    {
    blackhouseGame.currentmiddlemap.leftdoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentmiddlemap.mapid?middleroom_leftarrow_offset=false:middleroom_leftarrow_offset=true;
    blackhouseGame.currentmiddlemap.updoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentmiddlemap.mapid?middleroom_uparrow_offset=false:middleroom_uparrow_offset=true;
    blackhouseGame.currentmiddlemap.rightdoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentmiddlemap.mapid?middleroom_rightarrow_offset=false:middleroom_rightarrow_offset=true;
    blackhouseGame.currentmiddlemap.downdoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentmiddlemap.mapid?middleroom_downarrow_offset=false:middleroom_downarrow_offset=true;
    blackhouseGame.currentmiddlemap.themiddleroom!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentmiddlemap.mapid?middleroom_middlearrow_offset=false:middleroom_middlearrow_offset=true;
    }
    else
      {
        middleroom_leftarrow_offset=true;
        middleroom_uparrow_offset=true;
        middleroom_rightarrow_offset=true;
        middleroom_downarrow_offset=true;
        middleroom_middlearrow_offset=true;
      }

    //右边地图块的门可见属性设置
    if(blackhouseGame.currentrightmap!=null)
      {
    blackhouseGame.currentrightmap.leftdoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentrightmap.mapid?rightroom_leftarrow_offset=false:rightroom_leftarrow_offset=true;
    blackhouseGame.currentrightmap.updoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentrightmap.mapid?rightroom_uparrow_offset=false:rightroom_uparrow_offset=true;
    blackhouseGame.currentrightmap.rightdoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentrightmap.mapid?rightroom_rightarrow_offset=false:rightroom_rightarrow_offset=true;
    blackhouseGame.currentrightmap.downdoor!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentrightmap.mapid?rightroom_downarrow_offset=false:rightroom_downarrow_offset=true;
    blackhouseGame.currentrightmap.themiddleroom!=0&&blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid==blackhouseGame.currentrightmap.mapid?rightroom_middlearrow_offset=false:rightroom_middlearrow_offset=true;
    }
    else
      {
        rightroom_leftarrow_offset=true;
        rightroom_uparrow_offset=true;
        rightroom_rightarrow_offset=true;
        rightroom_downarrow_offset=true;
        rightroom_middlearrow_offset=true;
      }
  }

  void changePlayer()
  {
    //先更改id
    if(blackhouseGame.currentplayer<=5)
      blackhouseGame.currentplayer+=1;
    else blackhouseGame.currentplayer=1;
    //再完成地图模块的切换
    int player_mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
    //如果在左边,重新画图
    if(blackhouseGame.maps[player_mapid].lastlocation==1)
      {
        blackhouseGame.currentleftmap=blackhouseGame.maps[player_mapid];
        if(blackhouseGame.currentleftmap.therightroom!=0)
        {
          blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentleftmap.therightroom];
          if(blackhouseGame.currentmiddlemap.therightroom!=0)
          {
            blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.therightroom];
          }
          else blackhouseGame.currentrightmap=blackhouseGame.maps[101];
        }
        else
        {
          blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
          blackhouseGame.currentrightmap=blackhouseGame.maps[101];
        };
      }
    //如果在中间
    else if(blackhouseGame.maps[player_mapid].lastlocation==2)
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[player_mapid];
        if(blackhouseGame.currentmiddlemap.theleftroom!=0)
        {
          blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theleftroom];
        }
        else blackhouseGame.currentleftmap=blackhouseGame.maps[100];
        if(blackhouseGame.currentmiddlemap.therightroom!=0)
        {
          blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.therightroom];
        }
        else blackhouseGame.currentrightmap=blackhouseGame.maps[101];
      }
    //如果在右边
    else if(blackhouseGame.maps[player_mapid].lastlocation==3)
      {
        blackhouseGame.currentrightmap=blackhouseGame.maps[player_mapid];
        if(blackhouseGame.currentrightmap.theleftroom!=0)
        {
          blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentrightmap.theleftroom];
          if(blackhouseGame.currentmiddlemap.theleftroom!=0)
          {
            blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theleftroom];
          }
          else blackhouseGame.currentleftmap=blackhouseGame.maps[101];
        }
        else
        {
          blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
          blackhouseGame.currentleftmap=blackhouseGame.maps[101];
        };
      }
  }

  void changeScence()
  {
    //再完成地图模块的切换
    int player_mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
    //如果在左边,重新画图
    if(blackhouseGame.maps[player_mapid].lastlocation==1)
    {
      blackhouseGame.currentleftmap=blackhouseGame.maps[player_mapid];
      if(blackhouseGame.currentleftmap.therightroom!=0)
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[blackhouseGame.currentleftmap.therightroom];
        if(blackhouseGame.currentmiddlemap.therightroom!=0)
        {
          blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.therightroom];
        }
        else blackhouseGame.currentrightmap=blackhouseGame.maps[101];
      }
      else
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentrightmap=blackhouseGame.maps[101];
      };
    }
    //如果在中间
    else if(blackhouseGame.maps[player_mapid].lastlocation==2)
    {
      blackhouseGame.currentmiddlemap=blackhouseGame.maps[player_mapid];
      if(blackhouseGame.currentmiddlemap.theleftroom!=0)
      {
        blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theleftroom];
      }
      else blackhouseGame.currentleftmap=blackhouseGame.maps[100];
      if(blackhouseGame.currentmiddlemap.therightroom!=0)
      {
        blackhouseGame.currentrightmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.therightroom];
      }
      else blackhouseGame.currentrightmap=blackhouseGame.maps[101];
    }
    //如果在右边
    else if(blackhouseGame.maps[player_mapid].lastlocation==3)
    {
      blackhouseGame.currentrightmap=blackhouseGame.maps[player_mapid];
      if(blackhouseGame.currentrightmap.theleftroom!=0)
      {
        blackhouseGame.currentm iddlemap=blackhouseGame.maps[blackhouseGame.currentrightmap.theleftroom];
        if(blackhouseGame.currentmiddlemap.theleftroom!=0)
        {
          blackhouseGame.currentleftmap=blackhouseGame.maps[blackhouseGame.currentmiddlemap.theleftroom];
        }
        else blackhouseGame.currentleftmap=blackhouseGame.maps[101];
      }
      else
      {
        blackhouseGame.currentmiddlemap=blackhouseGame.maps[100];
        blackhouseGame.currentleftmap=blackhouseGame.maps[101];
      };
    }
  }

  void refreshPlayers()
  {
    //再放置玩家
    for(int i=1;i<=blackhouseGame.playernum;i++)
    {
      if(blackhouseGame.persons[i].currentmapid==blackhouseGame.currentleftmap.mapid) {
        blackhouseGame.persons[i].position=blackhouseGame.leftpersonoffsetmap[i];
        blackhouseGame.persons[i].scalerate=1;
        blackhouseGame.currentpersons[i] = blackhouseGame.persons[i];
      }
      else if(blackhouseGame.persons[i].currentmapid==blackhouseGame.currentrightmap.mapid) {
        blackhouseGame.persons[i].position=blackhouseGame.rightpersonoffsetmap[i];
        blackhouseGame.persons[i].scalerate=1;
        blackhouseGame.currentpersons[i] = blackhouseGame.persons[i];
      }
      else if(blackhouseGame.persons[i].currentmapid==blackhouseGame.currentmiddlemap.mapid) {
        blackhouseGame.persons[i].position=blackhouseGame.middlepersonoffsetmap[i];
        blackhouseGame.persons[i].scalerate=1;
        blackhouseGame.currentpersons[i] = blackhouseGame.persons[i];
      }
      else {
        blackhouseGame.currentpersons[i]=null;
      }
    }

  }

  //掷骰子
  Future rollTheDice(List<int> dicelist) async{
    //先让骰子转起来
    for(int i=1;i<=dicelist.length;i++)
    {
        blackhouseGame.dicesmap[i].actionshow=true;
    }
    //动画效果停2秒
    await Future.delayed(const Duration(milliseconds: 1000), () {
    });

    //然后再掷骰子
    for(int i=1;i<=8;i++)
    {
        if(i<=dicelist.length) {
          var dicerandom = new Random();
          int num = dicerandom.nextInt(3);
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
    }

  }

  Future comeIntoNewMap() async{
    int tempchoosedMapID=choosedMapID;
    int tempchooseMapDoor=chooseMapDoor;
    changeScence();
    refreshPlayers();
    await Future.delayed(const Duration(milliseconds: 1000), () {
    });
    setState(() {

    });
      //左边
        if(blackhouseGame.maps[tempchoosedMapID].lastlocation==1)
        {
            switch(tempchooseMapDoor){
              case 1:
                await leftroom_leftarrow_fun();
                break;
              case 2:
                await leftroom_uparrow_fun();
                break;
              case 3:
                await leftroom_rightarrow_fun();
                break;
              case 4:
                await leftroom_downarrow_fun();
                break;
            }
        }
        //中间
        else if(blackhouseGame.maps[tempchoosedMapID].lastlocation==2)
        {
          switch(tempchooseMapDoor){
            case 1:
              await middleroom_leftarrow_fun();
              break;
            case 2:
              await middleroom_uparrow_fun();
              break;
            case 3:
              await middleroom_rightarrow_fun();
              break;
            case 4:
              await middletroom_downarrow_fun();
              break;
          }
        }
        //右边
        else if(blackhouseGame.maps[tempchoosedMapID].lastlocation==3)
        {
          switch(tempchooseMapDoor){
            case 1:
              await rightroom_leftarrow_fun();
              break;
            case 2:
              await rightroom_uparrow_fun();
              break;
            case 3:
              await rightroom_rightarrow_fun();
              break;
            case 4:
              await righttroom_downarrow_fun();
              break;

          }
        }
  }

  //39呼唤 事件
  Future call() async{
    String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
    int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
    String mapname=blackhouseGame.maps[mapid].roomname;
    int playerID=blackhouseGame.currentplayer;
    await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“呼唤”");
    await showEventCard(39,blackhouseGame);
    await showToast("正在进行神志检定");
    int tempplayerid=playerID;
    for(int i=0 ;i<blackhouseGame.playernum;i++) {
      int playermapid = blackhouseGame.persons[tempplayerid].currentmapid;
      //不在露台、塔楼、花园、墓园、天井则不判断
      if (playermapid != 20 && playermapid != 24 && playermapid != 34 &&
          playermapid != 35 && playermapid != 36) {
        tempplayerid=tempplayerid+1;
        if(tempplayerid>6)
          tempplayerid=1;
        continue;
      }
      int sanitystage = blackhouseGame.persons[tempplayerid].currentsanity;
      int sanity=blackhouseGame.persons[tempplayerid].sanitylist[sanitystage];
      String playernow = blackhouseGame.persons[tempplayerid].playername;
      sanity=await getDiceNum(context,blackhouseGame,tempplayerid,sanity,0);

      if(sanity>=5)
      {
        await showToast("你在窗户边缘停了下来");
      }
      else
      {
        //如果天井被翻开
        if(blackhouseGame.maps[36].isopen)
        {
          await showToast("玩家$playernow跳到了天井，并受到1点骰子物理伤害");
          blackhouseGame.persons[tempplayerid].currentmapid=36;
          int tempcurrentplayer=blackhouseGame.currentplayer;
          blackhouseGame.currentplayer=tempplayerid;
          changeScence();
          refreshPlayers();
          await Future.delayed(const Duration(milliseconds: 1000), () {
          });
          await BodyDamageByDiceNum(context, 1, blackhouseGame, tempplayerid);
          blackhouseGame.currentplayer=tempcurrentplayer;
        }
        else
        {
          await showToast("玩家$playernow跳到了天井，并受到1点骰子物理伤害");
          await chooseRoomDoorsOfGivenRoom(blackhouseGame,2,36);
          //若没有合适的地方放置，跳过效果
          if(choosedMapID==0&&chooseMapDoor==0)
            return;
          int tempcurrentplayer=blackhouseGame.currentplayer;
          blackhouseGame.currentplayer=tempplayerid;
          blackhouseGame.persons[tempplayerid].currentmapid=choosedMapID;
          changeScence();
          refreshPlayers();
          setChooseOpenRoom=36;
          await BodyDamageByDiceNum(context, 1, blackhouseGame, tempplayerid);
          await comeIntoNewMap();
          blackhouseGame.currentplayer=tempcurrentplayer;
        }
      }
      tempplayerid=tempplayerid+1;
      if(tempplayerid>6)
        tempplayerid=1;
    }
  }

  //44这是哪
  Future wheresThis() async{
    String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
    int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
    String mapname=blackhouseGame.maps[mapid].roomname;
    int playerID=blackhouseGame.currentplayer;
    await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“这是哪”");
    await showEventCard(44,blackhouseGame);
    await showToast("玩家$currentplayername感觉房间移动了,正在随机移动房间");
    int layer=blackhouseGame.maps[mapid].currentlayer;
    blackhouseGame.maps[mapid].isopen=false;
    for(int i=0;i<4;i++) {
      await chooseRoomDoorsOfGivenRoom(blackhouseGame, layer, mapid);
      //若没有合适的地方放置，跳过效果
      if (choosedMapID != 0 && chooseMapDoor != 0)
        break;
      layer +=1;
      if(layer>4)
        layer=1;
    }
    if(choosedMapID != 0 && chooseMapDoor != 0){
    blackhouseGame.persons[playerID].currentmapid=choosedMapID;
    if(blackhouseGame.maps[mapid].theleftroom!=0)
      {
    blackhouseGame.maps[blackhouseGame.maps[mapid].theleftroom].therightroom=0;
    blackhouseGame.maps[mapid].theleftroom=0;
    }
    if(blackhouseGame.maps[mapid].therightroom!=0){
    blackhouseGame.maps[blackhouseGame.maps[mapid].therightroom].theleftroom=0;
    blackhouseGame.maps[mapid].therightroom=0;
    }
    if(blackhouseGame.maps[mapid].theuproom!=0) {
      blackhouseGame.maps[blackhouseGame.maps[mapid].theuproom].thedownroom = 0;
      blackhouseGame.maps[mapid].theuproom=0;
    }
    if(blackhouseGame.maps[mapid].thedownroom!=0) {
      blackhouseGame.maps[blackhouseGame.maps[mapid].thedownroom].theuproom = 0;
      blackhouseGame.maps[mapid].thedownroom=0;
    }
    changeScence();
    refreshPlayers();
    setChooseOpenRoom=mapid;
    await comeIntoNewMap();}
    else{
      await showToast("房间移动回了原处");
      blackhouseGame.maps[mapid].isopen=true;
    }
  }

  //55墙上有眼 modify by gaoyang 2021-1-15
  Future eyesOnTheWall() async{
    String currentplayername=blackhouseGame.persons[blackhouseGame.currentplayer].playername;
    int mapid=blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid;
    String mapname=blackhouseGame.maps[mapid].roomname;
    int playerID=blackhouseGame.currentplayer;
    int currentsanitystage=blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity;
    int currentsanity=blackhouseGame.persons[blackhouseGame.currentplayer].sanitylist[currentsanitystage];
    int currentknowledgestage=blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge;
    int currentknowledge=blackhouseGame.persons[blackhouseGame.currentplayer].knowledgelist[currentknowledgestage];
    await showToast("玩家${currentplayername}在房间${mapname}遭遇了事件“墙上有眼”");
    await showEventCard(55,blackhouseGame);
    await showToast("正在进行神志检定");
    currentsanity=await getDiceNum(context,blackhouseGame,playerID,currentsanity,0);

    if(currentsanity >=0 && currentsanity <=2){
      await showToast("玩家${currentplayername}神志为${currentsanity}，神志降低1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentsanity -= 1;
    }else if(currentsanity == 3){
      await showToast("玩家${currentplayername}神志为${currentsanity}，知识为${currentknowledge},知识提升1级");
      blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge+= 1;
      if(blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge<1)
        blackhouseGame.persons[blackhouseGame.currentplayer].currentknowledge=1;
    }else if(currentsanity >=4){
      if(blackhouseGame.maps[62].isopen)
      {
        await showToast("玩家${currentplayername}被移动到了军火库，并抽取了物品");
        blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=62;
        await ItemEmit.triggerTheItem(context, blackhouseGame);

      }
      else{
        await chooseRoomDoorsOfGivenRoom(blackhouseGame,2,62);
        //若没有合适的地方放置，跳过效果
        if(choosedMapID==0&&chooseMapDoor==0)
          {
            await chooseRoomDoorsOfGivenRoom(blackhouseGame,1,62);
            if(choosedMapID==0&&chooseMapDoor==0)
            {
              await showToast("没有合适的位置放置军火库，跳过卡牌效果");
              return;
            }
          }
        blackhouseGame.persons[blackhouseGame.currentplayer].currentmapid=choosedMapID;
        changeScence();
        refreshPlayers();
        setChooseOpenRoom=62;
        await comeIntoNewMap();

      }
    }
  }
}
