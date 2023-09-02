import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:blackhouse/component/background/background.dart';
import 'package:blackhouse/maps/map.dart';
import 'package:blackhouse/maps/initmaps.dart';
import 'package:blackhouse/persons/person.dart';
import 'package:blackhouse/toolbar/toolbarbg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blackhouse/cards/eventCards/eventscard.dart';
import 'package:blackhouse/cards/itemsCards/itemscard.dart';
import 'package:blackhouse/cards/omensCards/omenscard.dart';

import 'package:flame/spritesheet.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/position.dart';
import 'package:blackhouse/dices/dices.dart';
import 'package:blackhouse/config/param.dart';
import 'package:blackhouse/tools/cardstools.dart';

import 'dart:math';


class coordinate{
  int mapid=0;
  int x=100;
  int y=100;
  int currentlayer=0;
  coordinate(this.mapid,this.x,this.y,this.currentlayer);
}

class BlackHouseGame extends BaseGame
    with TapDetector,DoubleTapDetector,PanDetector,LongPressDetector{
  Size screenSize;

  GameBackground bg;
  //界面提示
  String tips=" ";
  bool showtips=false;
  //地图块
  Map<int, Mapblock> maps = new Map();
  //物品牌
  Map<int, ItemsCard> itemsmap = new Map();
  //事件牌
  Map<int, EventsCard> eventsmap = new Map();
  //征兆牌
  Map<int, OmensCard> omensmap = new Map();
  //地图坐标方位，key:楼层_x_y, 以门口大厅为（2_0_0） ,地下室入口（1_0_0), 上层（2_0_0),顶层（3_0_0)
  Map<String, coordinate> mapcoordinate = new Map();

  Offset leftoffset = Offset(0, 0); //左边地图块的位置
  Offset middleoffset = Offset(0, 0); //中间地图块的位置
  Offset rightoffset = Offset(0, 0); //右边地图块的位置
  Offset ratewidgetoffset = Offset(0, 0); //中间选择的地图块
  Mapblock currentleftmap; //当前画面左边的map
  Mapblock currentmiddlemap; //当前画面中间的map
  Mapblock currentrightmap; //当前画面右间的map
  Mapblock currenchoosemap; //当前画面玩家抽取出来的地图展示

  bool iseventCardShow=false;
  EventsCard currentEventCard;  //当前的事件牌
  int currentEventCardID=0;

  bool isitemCardShow=false;
  ItemsCard currentItemCard;  //当前的物体牌
  int currentItemCardID=0;

  bool isomenCardShow=false;
  OmensCard currentOmenCard;  //当前的预兆牌
  int currentOmenCardID=0;

  int count = 0;


  bool isshowlittemap = false; //是否展示小地图
  int showlayer = 0;
  Map<String, Mapblock> littemaps = new Map(); //小地图的表格


  Map<int, Offset> leftpersonoffsetmap = new Map(); //左边地图块人物的位置
  Map<int, Offset> middlepersonoffsetmap = new Map(); //中间地图块人物的位置
  Map<int, Offset> rightpersonoffsetmap = new Map(); //右边地图块人物的位置
  Map<int, Person> persons = new Map();
  Map<int, Person> currentpersons = new Map();
  Map<int, Dices> dicesmap= new Map();                //8颗骰子
  int playernum = 6;
  int currentplayer = 1;

  //操作框
  ToolBarBackground toolbarbox;

  @override
  void onTapDown(TapDownDetails details){
    if(ischooseroom)
    {
      isMatchMapArea(details.globalPosition.dx,details.globalPosition.dy);
    }
    print("tapgame${details.globalPosition.dx},${details.globalPosition.dy}");

    if(ischooseRoomDoor)
    {
      isMatchMapDoorArea(details.globalPosition.dx,details.globalPosition.dy);
    }
  }

  //点击的位置是否和小地图位置匹配
  Future isMatchMapArea(double x, double y) async{
    mapcoordinate.forEach((key, value) async{
      if (key.split("_")[0] =="$showlayer")
      {
        String keystr = "${(value.x + 4) * 80}_${(value.y + 4) * 80}";
        double mapx=littemaps[keystr].position.dx;
        double mapy=littemaps[keystr].position.dy;

        double width=ScreenUtil().setWidth(400*littemaps[keystr].maprate);
        double height=width;

        if(x>=mapx&&x<=(mapx+width)&&y>=mapy&&y<=(mapy+height))
          {
            choosedMapID=littemaps[keystr].mapid;
            return true;
          }
      }
    });

    return false;
  }

  //点击的位置是否和小地图可选门位置匹配
  Future isMatchMapDoorArea(double x, double y) async{
    mapcoordinate.forEach((key, value) async{
      if (key.split("_")[0] =="$showlayer")
      {
        String keystr = "${(value.x + 4) * 80}_${(value.y + 4) * 80}";
        double mapx=littemaps[keystr].position.dx;
        double mapy=littemaps[keystr].position.dy;

        double width=ScreenUtil().setWidth(400*littemaps[keystr].maprate);
        double height=width;

        if(x>=mapx&&x<=(mapx+width)&&y>=mapy&&y<=(mapy+height))
        {
          int tempmapid=littemaps[keystr].mapid;
          if(maps[tempmapid].theleftroom==0&&maps[tempmapid].leftdoor!=0)
          {
              if(x>=mapx&&x<=(mapx+width/4)&&y>=(mapy+height*3/8)&&y<=(mapy+height*5/8))
                {
                  choosedMapID=littemaps[keystr].mapid;
                  chooseMapDoor=1;
                  print("press${maps[tempmapid].roomname}左边的门");
                  return true;
                }
          }
          if(maps[tempmapid].theuproom==0&&maps[tempmapid].updoor!=0)
          {
            if(x>=(mapx+width*3/8)&&x<=(mapx+width*5/8)&&y>=0&&y<=(mapy+height/4))
            {
              choosedMapID=littemaps[keystr].mapid;
              chooseMapDoor=2;
              print("press${maps[tempmapid].roomname}上边的门");
              return true;
            }
          }
          if(maps[tempmapid].therightroom==0&&maps[tempmapid].rightdoor!=0)
          {
            if(x>=(mapx+width*3/4)&&x<=(mapx+width)&&y>=(mapy+height*3/8)&&y<=(mapy+height*5/8))
            {
              choosedMapID=littemaps[keystr].mapid;
              chooseMapDoor=3;
              print("press${maps[tempmapid].roomname}右边的门");
              return true;
            }
          }
          if(maps[tempmapid].thedownroom==0&&maps[tempmapid].downdoor!=0)
          {
            if(x>=(mapx+width*3/8)&&x<=(mapx+width*5/8)&&y>=(mapy+height*3/4)&&y<=(mapy+height))
            {
              choosedMapID=littemaps[keystr].mapid;
              chooseMapDoor=4;
              print("press${maps[tempmapid].roomname}下边的门");
              return true;
            }
          }

        }
      }
    });

    return false;
  }

  @override
  void render(Canvas canvas) {
    if (screenSize == null) {
      return;
    }
    if (maps == null || maps.length == 0)
      initMapblocks();
    if (persons == null || persons.length == 0)
      initPersons();
    if(itemsmap==null||itemsmap.length==0)
      initItems();
    if(eventsmap==null||eventsmap.length==0)
      initEvents();
    if(omensmap==null||omensmap.length==0)
      initOmens();
    if(dicesmap==null||dicesmap.length==0)
      initDices();

    //绘制背景
    bg.render(canvas);


    //绘制地图
    if (currentleftmap != null) {
      currentleftmap.position = leftoffset;
      currentleftmap.maprate = 1;
      currentleftmap.render(canvas);
    }
    if (currentmiddlemap != null) {
      currentmiddlemap.position = middleoffset;
      currentmiddlemap.maprate = 1;
      currentmiddlemap.render(canvas);
    }
    if (currentrightmap != null) {
      currentrightmap.position = rightoffset;
      currentrightmap.maprate = 1;
      currentrightmap.render(canvas);
    }

    if (currenchoosemap != null) {
      currenchoosemap.position = ratewidgetoffset;
      currenchoosemap.maprate = 1;
      currenchoosemap.render(canvas);
    }


    if (isshowlittemap) {
      int xmin = 0;
      int ymin = 0;
      int xmax = 0;
      int ymax = 0;

      mapcoordinate.forEach((key, value) {
        if ((key.split("_")[0] == ("1") && showlayer == 1)
            || (key.split("_")[0] == ("2") && showlayer == 2)
            || (key.split("_")[0] == ("3") && showlayer == 3)
            || (key.split("_")[0] == ("4") && showlayer == 4)) {
          value.x > xmax ? xmax = value.x : xmax = xmax;
          value.y > ymax ? ymax = value.y : ymax = ymax;
          value.x < xmin ? xmin = value.x : xmin = xmin;
          value.y < ymin ? ymin = value.y : ymin = ymin;
        }
      });

      int xsize = xmax - xmin;
      int ysize = ymax - ymin;
      double rate = 0.2;
      if (xsize <= 5 && ysize < 4)
        rate = 0.35;
      else if (ysize >= 4 && ysize < 5)
        rate = 0.3;
      else if (ysize >= 5 && ysize < 6)
        rate = 0.25;
      else if (ysize >= 6 && ysize < 8)
        rate = 0.2;
      else if (ysize >= 8 && ysize < 11)
        rate = 0.15;
      else
        rate = 0.1;

      mapcoordinate.forEach((key, value) {
        if ((key.split("_")[0] == ("1") && showlayer == 1)
            || (key.split("_")[0] == ("2") && showlayer == 2)
            || (key.split("_")[0] == ("3") && showlayer == 3)
            || (key.split("_")[0] == ("4") && showlayer == 4)) {
          String keystr = "${(value.x + 4) * 80}_${(value.y + 4) *
              80}";
          littemaps[keystr] = maps[value.mapid];
          littemaps[keystr].maprate = rate;
          Offset offset = Offset(
              (screenSize.width - ScreenUtil().setWidth(720)) / 2 +
                  (value.x - xmin) *
                      ScreenUtil().setWidth(400 * littemaps[keystr].maprate),
              (screenSize.height - ScreenUtil().setHeight(720)) / 2 +
                  (value.y - ymin) *
                      ScreenUtil().setWidth(400 * littemaps[keystr].maprate));
          littemaps[keystr].position = offset;
          littemaps[keystr].render(canvas);
        }
      });

      //在小地图刷新玩家
      bool ismatchplayer = false;
      //再放置玩家
      for (int i = 1; i <= playernum; i++) {
        ismatchplayer = false;
        mapcoordinate.forEach((key, value) {
          if ((key.split("_")[0] == ("1") && showlayer == 1)
              || (key.split("_")[0] == ("2") && showlayer == 2)
              || (key.split("_")[0] == ("3") && showlayer == 3)
              || (key.split("_")[0] == ("4") && showlayer == 4)) {
            if (persons[i].currentmapid == value.mapid) {
              Offset offset = Offset(
                  (screenSize.width - ScreenUtil().setWidth(720)) / 2 +
                      (value.x - xmin) * ScreenUtil().setWidth(400 * rate) +
                      ScreenUtil().setWidth(10 * rate * (i > 3 ? i - 3 : i)),
                  (screenSize.height - ScreenUtil().setHeight(720)) / 2 +
                      (value.y - ymin) * ScreenUtil().setWidth(400 * rate) +
                      ScreenUtil().setWidth(10 * rate * (i > 3 ? i - 3 : i)));
              persons[i].position = offset;
              persons[i].scalerate = rate * 3;
              currentpersons[i] = persons[i];
              ismatchplayer = true;
            }
          }
        });

        if (ismatchplayer == false) {
          currentpersons[i] = null;
        }
      }
    }

    //绘制工具框
    if (!isshowlittemap) {
      toolbarbox.render(canvas);
    }

    //绘制事件卡
    if(currentEventCard!=null&&iseventCardShow){
      currentEventCard.position=Offset(middleoffset.dx+50,middleoffset.dy+20);
      currentEventCard.render(canvas);
    }
    else if(currentItemCard!=null&&isitemCardShow){
      currentItemCard.position=Offset(middleoffset.dx+50,middleoffset.dy+20);
      currentItemCard.render(canvas);
    }
    else if(currentOmenCard!=null&&isomenCardShow){
      currentOmenCard.position=Offset(middleoffset.dx+50,middleoffset.dy+20);
      currentOmenCard.render(canvas);
    }
    else {
      if (dicesmap != null) {
        for (int i = 1; i <= dicesmap.length; i++) {
          if (dicesmap[i].diceshow)
            dicesmap[i].render(canvas);
        }
      }

      double lastx = 0;
      double lasty = 0;

      if (dicesmap != null) {
        for (int i = 1; i <= dicesmap.length; i++) {
          if (dicesmap[i].actionshow) {
            dicesmap[i].actionDiceComponent.x = dicesmap[i].position.dx - lastx;
            dicesmap[i].actionDiceComponent.y = dicesmap[i].position.dy - lasty;
            lastx = dicesmap[i].position.dx;
            lasty = dicesmap[i].position.dy;
            dicesmap[i].actionDiceComponent.render(canvas);
          }
        }
      }

      //这里面多个精灵队列，直接使用position有个偏移量，不知为何，可能是bug
      if (currentpersons != null) {
        for (int i = 1; i <= playernum; i++) {
          if (currentpersons[i] != null) {
            currentpersons[i].personcomponent.x =
                currentpersons[i].position.dx - lastx;
            currentpersons[i].personcomponent.y =
                currentpersons[i].position.dy - lasty;
            lastx = currentpersons[i].position.dx;
            lasty = currentpersons[i].position.dy;
            if (currentpersons[i].direct == "left")
              currentpersons[i].personcomponent.animation.frames =
                  currentpersons[i].personcomponentleft.frames;
            else if (currentpersons[i].direct == "right")
              currentpersons[i].personcomponent.animation.frames =
                  currentpersons[i].personcomponentright.frames;
            else if (currentpersons[i].direct == "back")
              currentpersons[i].personcomponent.animation.frames =
                  currentpersons[i].personcomponentback.frames;
            else if (currentpersons[i].direct == "front")
              currentpersons[i].personcomponent.animation.frames =
                  currentpersons[i].personcomponentfront.frames;
            else
              currentpersons[i].personcomponent.animation.frames =
                  currentpersons[i].personcomponentfront.frames;


            currentpersons[i].personcomponent.render(canvas);

            //小地图展示不下
            if (!isshowlittemap)
              currentpersons[i].render(canvas);
          }
        }
      }
    }


  }

  @override
  void update(double t) {
    if (screenSize == null) {
      return;
    }

    double lastx=0;
    double lasty=0;

    if(dicesmap != null){
      for(int i=1;i<=dicesmap.length;i++)
      {

          if (dicesmap[i].actionshow) {
            dicesmap[i].actionDiceComponent.x = dicesmap[i].position.dx-lastx;
            dicesmap[i].actionDiceComponent.y = dicesmap[i].position.dy-lasty;
            lastx=dicesmap[i].position.dx;
            lasty=dicesmap[i].position.dy;
            dicesmap[i].actionDiceComponent.update(t);
        }
      }
    }
      if(currentpersons!=null) {

        for (int i = 1; i <= playernum; i++) {
          if (currentpersons[i] != null) {

            currentpersons[i].personcomponent.x=currentpersons[i].position.dx-lastx;
            currentpersons[i].personcomponent.y=currentpersons[i].position.dy-lasty;
            lastx=currentpersons[i].position.dx;
            lasty=currentpersons[i].position.dy;

          if(currentpersons[i].direct=="left")
              currentpersons[i].personcomponent.animation.frames=currentpersons[i].personcomponentleft.frames;
            else if(currentpersons[i].direct=="right")
              currentpersons[i].personcomponent.animation.frames=currentpersons[i].personcomponentright.frames;
            else if(currentpersons[i].direct=="back")
              currentpersons[i].personcomponent.animation.frames=currentpersons[i].personcomponentback.frames;
            else if(currentpersons[i].direct=="front")
              currentpersons[i].personcomponent.animation.frames=currentpersons[i].personcomponentfront.frames;
            else
              currentpersons[i].personcomponent.animation.frames=currentpersons[i].personcomponentfront.frames;

            currentpersons[i].personcomponent.update(t);
          }
        }


    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
    if (maps == null || maps.length == 0)
      initMapblocks();
    if (persons == null || persons.length == 0)
      initPersons();
    if(itemsmap==null||itemsmap.length==0)
      initItems();
    if(eventsmap==null||eventsmap.length==0)
      initEvents();
    if(omensmap==null||omensmap.length==0)
      initOmens();
    if(dicesmap==null||dicesmap.length==0)
      initDices();

    //initEnemyTank();
    if (bg == null) {
      bg = GameBackground(this);
    }


    if (toolbarbox == null) {
      toolbarbox = ToolBarBackground(
        this, position: Offset(
          (screenSize.width - ScreenUtil().setWidth(1200)) / 2,
          screenSize.height / 8 + ScreenUtil().setHeight(450)),
      );
    }
  }

  ///初始化地图块
  void initMapblocks() {
    leftoffset = Offset((screenSize.width - ScreenUtil().setWidth(1200)) / 2,
        screenSize.height / 6);
    middleoffset = Offset((screenSize.width - ScreenUtil().setWidth(1200)) / 2 +
        ScreenUtil().setWidth(400), screenSize.height / 6);
    rightoffset = Offset((screenSize.width - ScreenUtil().setWidth(1200)) / 2 +
        ScreenUtil().setWidth(800), screenSize.height / 6);
    //翻开的新房间地图选择方向
    ratewidgetoffset = Offset(screenSize.width / 3, screenSize.height / 6);
    //大厅地图块3块加载
    for (int i = 1; i <= 3; i++) {
      if (i == 3) {
        var mapSprite = Sprite(
            'maps/startRooms.png', x: 900, y: 0, width: 515, height: 450);
        maps.putIfAbsent(3, () => Mapblock(this, mapSprite, leftoffset, i));
      }
      else {
        var mapSprite = Sprite(
            'maps/startRooms.png', x: ((i - 1) * 450).toDouble(),
            y: 0,
            width: 450,
            height: 450);
        maps.putIfAbsent(i, () => Mapblock(this, mapSprite, leftoffset, i));
      }
    }

    //44块地图块存入
    for (int j = 1; j <= 5; j++) {
      for (int i = 1; i <= 10; i++) {
        if (((j - 1) * 10 + i) > 44) break; //图片上只有44张地图块
        var mapSprite = Sprite('maps/Rooms1.jpg', x: ((i - 1) * 450).toDouble(),
            y: ((j - 1) * 450).toDouble(),
            width: 450,
            height: 450);
        //继续前面的计数
        maps.putIfAbsent((j - 1) * 10 + i + 3, () =>
            Mapblock(this, mapSprite, leftoffset, (j - 1) * 10 + i + 3));
      }
    }

    //图3的20块地图存入
    for (int j = 1; j <= 2; j++) {
      for (int i = 1; i <= 10; i++) {
        var mapSprite = Sprite('maps/Rooms2.jpg', x: ((i - 1) * 450).toDouble(),
            y: ((j - 1) * 450).toDouble(),
            width: 450,
            height: 450);
        //继续前面的计数
        maps.putIfAbsent((j - 1) * 10 + i + 47, () =>
            Mapblock(this, mapSprite, leftoffset, (j - 1) * 10 + i + 47));
      }
    }

    //设置黑色块代表未探索过的区域, 房间号为100，101号
    var mapSprite100 = Sprite('maps/Rooms1.jpg', x: (6 * 450).toDouble(),
        y: (4 * 450).toDouble(),
        width: 450,
        height: 450);
    maps.putIfAbsent(100, () => Mapblock(this, mapSprite100, leftoffset, 100));

    var mapSprite101 = Sprite('maps/Rooms1.jpg', x: (7 * 450).toDouble(),
        y: (4 * 450).toDouble(),
        width: 450,
        height: 450);
    maps.putIfAbsent(101, () => Mapblock(this, mapSprite101, leftoffset, 101));

    initMaps(maps);

    currentleftmap = maps[1];
    currentmiddlemap = maps[2];
    currentrightmap = maps[3];
    currenchoosemap = null; //一般都不显示

    maps[1].isopen = true; //上电梯
    maps[2].isopen = true; //门厅
    maps[3].isopen = true; //大厅
    maps[4].isopen = true; //上层
    maps[5].isopen = true; //地下室
    maps[48].isopen = true; //顶层

    maps[1].currentlayer = 2;
    maps[2].currentlayer = 2;
    maps[3].currentlayer = 2;
    maps[4].currentlayer = 3;
    maps[5].currentlayer = 1;
    maps[48].currentlayer = 4;

    maps[1].lastlocation = 1;
    maps[2].lastlocation = 2;
    maps[3].lastlocation = 3;
    maps[4].lastlocation = 3;
    maps[5].lastlocation = 3;
    maps[48].lastlocation = 3;

    maps[1].x = -2;
    maps[2].x = -1;
    maps[3].x = 0;
    maps[4].x = 0;
    maps[5].x = 0;
    maps[48].x = 0;

    maps[1].y = 0;
    maps[2].y = 0;
    maps[3].y = 0;
    maps[4].y = 0;
    maps[5].y = 0;
    maps[48].y = 0;

    mapcoordinate.putIfAbsent("2_0_0", () => new coordinate(3, 0, 0, 2));
    mapcoordinate.putIfAbsent("2_-1_0", () => new coordinate(2, -1, 0, 2));
    mapcoordinate.putIfAbsent("2_-2_0", () => new coordinate(1, -2, 0, 2));

    mapcoordinate.putIfAbsent("3_0_0", () => new coordinate(4, 0, 0, 3));
    mapcoordinate.putIfAbsent("1_0_0", () => new coordinate(5, 0, 0, 1));
    mapcoordinate.putIfAbsent("4_0_0", () => new coordinate(48, 0, 0, 4));
  }

  //初始化人物
  void initPersons() {
    for (int i = 1; i <= playernum; i++) {
      var leftpersonoffset = Offset(
          (screenSize.width - ScreenUtil().setWidth(1200)) / 2 +
              ScreenUtil().setWidth( 80 * (i > 3 ? i - 3 : i)),
          screenSize.height / 6 + ScreenUtil().setWidth(100 + 150 * (i % 2)));
      var middlepersonoffset = Offset(
          (screenSize.width - ScreenUtil().setWidth(1200)) / 2 +
              ScreenUtil().setWidth(400 + 80 * (i > 3 ? i - 3 : i)),
          screenSize.height / 6 + ScreenUtil().setWidth(100 + 150 * (i % 2)));
      var rightpersonoffset = Offset(
          (screenSize.width - ScreenUtil().setWidth(1200)) / 2 +
              ScreenUtil().setWidth(800 + 80 * (i > 3 ? i - 3 : i)),
          screenSize.height / 6 + ScreenUtil().setWidth(100 + 150 * (i % 2)));


      final spriteSheet =new  SpriteSheet(
        imageName: 'persons/person$i.png',
        textureWidth: 32,
        textureHeight: 48,
        columns: 4,
        rows: 4,
      );

      //default //flutter 深拷贝浅拷贝要注意
      final  vampireAnimationdefault =
      spriteSheet.createAnimation(0, stepTime: 0.2, to: 4);

      //正面
      final  vampireAnimationfront =
          spriteSheet.createAnimation(0, stepTime: 0.2, to: 4);

      //左边
      final vampireAnimationleft =
      spriteSheet.createAnimation(1, stepTime: 0.2, to: 4);

      //背面
      final vampireAnimationback =
      spriteSheet.createAnimation((i==1||i==6)?2:3, stepTime: 0.2, to: 4);

      //右边
      final vampireAnimationright =
      spriteSheet.createAnimation((i==1||i==6)?3:2, stepTime: 0.2, to: 4);

      final animationComponent  = new AnimationComponent(40, 60, vampireAnimationdefault);

      animationComponent.x = rightpersonoffset.dx;
      animationComponent.y = rightpersonoffset.dy;

      var arrowSprite = Sprite('down_arrow.png');

      persons.putIfAbsent(i, () =>
          new Person(this,animationComponent,vampireAnimationfront ,vampireAnimationleft  ,
              vampireAnimationright , vampireAnimationback , arrowSprite,rightpersonoffset, i, 'player$i'));
      leftpersonoffsetmap.putIfAbsent(i, () => leftpersonoffset);
      middlepersonoffsetmap.putIfAbsent(i, () => middlepersonoffset);
      rightpersonoffsetmap.putIfAbsent(i, () => rightpersonoffset);
      persons[i].currentmapid = 3;
      setPersonInfo(i);
    }
    currentpersons=new Map.from(persons);
  }

  //初始化人物名称和属性
  void setPersonInfo(int i){
    if(i==1)
      {
        persons[i].personname="朗费罗教授";
        persons[i].initspeed=4;
        persons[i].currentspeed=4;
        persons[i].initmight=3;
        persons[i].currentmight=3;
        persons[i].initsanity=3;
        persons[i].currentsanity=3;
        persons[i].initknowledge=5;
        persons[i].currentknowledge=5;
        persons[i].speedlist=[0,2,2,4,4,5,5,6,6];
        persons[i].mightlist=[0,1,2,3,4,5,5,6,6];
        persons[i].sanitylist=[0,1,3,3,4,5,5,6,7];
        persons[i].knowledgelist=[0,4,5,5,5,5,6,7,8];
      }
    else if(i==2)
      {
        persons[i].personname="左思泽";
        persons[i].initspeed=3;
        persons[i].currentspeed=3;
        persons[i].initmight=4;
        persons[i].currentmight=4;
        persons[i].initsanity=3;
        persons[i].currentsanity=3;
        persons[i].initknowledge=4;
        persons[i].currentknowledge=4;
        persons[i].speedlist=[0,2,3,3,5,5,6,6,7];
        persons[i].mightlist=[0,2,3,3,4,5,5,5,6];
        persons[i].sanitylist=[0,4,4,4,5,6,7,8,8];
        persons[i].knowledgelist=[0,1,3,4,4,4,5,6,6];
      }
    else if(i==3)
      {
        persons[i].personname="若伊";
        persons[i].initspeed=4;
        persons[i].currentspeed=4;
        persons[i].initmight=4;
        persons[i].currentmight=4;
        persons[i].initsanity=3;
        persons[i].currentsanity=3;
        persons[i].initknowledge=3;
        persons[i].currentknowledge=3;
        persons[i].speedlist=[0,4,4,4,4,5,6,8,8];
        persons[i].mightlist=[0,2,2,3,3,4,4,6,7];
        persons[i].sanitylist=[0,3,4,5,5,6,6,7,8];
        persons[i].knowledgelist=[0,1,2,3,4,4,5,5,5];
      }
    else if(i==4)
    {
      persons[i].personname="布兰登";
      persons[i].initspeed=3;
      persons[i].currentspeed=3;
      persons[i].initmight=4;
      persons[i].currentmight=4;
      persons[i].initsanity=4;
      persons[i].currentsanity=4;
      persons[i].initknowledge=3;
      persons[i].currentknowledge=3;
      persons[i].speedlist=[0,3,4,4,4,5,6,7,8];
      persons[i].mightlist=[0,2,3,3,4,5,6,6,7];
      persons[i].sanitylist=[0,3,3,3,4,5,6,7,8];
      persons[i].knowledgelist=[0,1,3,3,5,5,6,6,7];
    }
    else if(i==5)
    {
      persons[i].personname="珍妮";
      persons[i].initspeed=4;
      persons[i].currentspeed=4;
      persons[i].initmight=3;
      persons[i].currentmight=3;
      persons[i].initsanity=5;
      persons[i].currentsanity=5;
      persons[i].initknowledge=3;
      persons[i].currentknowledge=3;
      persons[i].speedlist=[0,2,3,4,4,4,5,6,8];
      persons[i].mightlist=[0,3,4,4,4,4,5,6,8];
      persons[i].sanitylist=[0,1,1,2,4,4,4,5,6];
      persons[i].knowledgelist=[0,2,3,3,4,4,5,6,8];
    }
    else if(i==6)
    {
      persons[i].personname="达瑞";
      persons[i].initspeed=5;
      persons[i].currentspeed=5;
      persons[i].initmight=3;
      persons[i].currentmight=3;
      persons[i].initsanity=3;
      persons[i].currentsanity=3;
      persons[i].initknowledge=3;
      persons[i].currentknowledge=3;
      persons[i].speedlist=[0,4,4,4,5,6,7,7,8];
      persons[i].mightlist=[0,2,3,3,4,5,6,6,7];
      persons[i].sanitylist=[0,1,2,3,4,5,5,5,7];
      persons[i].knowledgelist=[0,2,3,3,4,5,5,5,7];
    }
  }

    //初始化骰子
    void initDices()
    {
      for (int i=1;i<=8;i++) {
        var diceoffset = Offset(
            (screenSize.width - ScreenUtil().setWidth(500)) / 2 +
                ScreenUtil().setWidth( 80*(i>4?i-4:i)),
             i>4?screenSize.height/2 +ScreenUtil().setWidth(200):screenSize.height/2 +ScreenUtil().setWidth(120));
        final spriteSheet = new SpriteSheet(
          imageName: 'dice/diceaction.png',
          textureWidth: 100,
          textureHeight: 100,
          columns: 6,
          rows: 1,
        );

        final vampireAnimationdefault =
        spriteSheet.createAnimation(0, stepTime: 0.12+i*0.003, to: 6);

        final animationComponent = new AnimationComponent(
            ScreenUtil().setWidth(80), ScreenUtil().setWidth(80), vampireAnimationdefault);
         var diceSprite0 = Sprite('dice/dice_0.png');
         var diceSprite1 = Sprite('dice/dice_1.png');
         var diceSprite2 = Sprite('dice/dice_2.png');
         dicesmap.putIfAbsent(i, () =>Dices(this,animationComponent,diceSprite0,diceSprite1,diceSprite2,diceoffset,i));

         dicesmap[i].actionshow = false;
         dicesmap[i].diceshow = false;

         dicesmap[i].diceNum=1;
      }
    }

    //初始化物品
    void initItems() {
      for (int j = 1; j <= 2; j++) {
        for (int i = 1; i <= 10; i++) {
          if (((j - 1) * 10 + i) > 11) break;
          var mapSprite = Sprite(
              'cards/items01.jpg', x: ((i - 1) * 565).toDouble(),
              y: ((j - 1) * 1080).toDouble(),
              width: 565,
              height: 1080);
          //继续前面的计数
          itemsmap.putIfAbsent((j - 1) * 10 + i, () =>
              ItemsCard(this, mapSprite, leftoffset, (j - 1) * 10 + i));
        }
      }

      for (int j = 1; j <= 5; j++) {
        for (int i = 1; i <= 10; i++) {
          if (((j - 1) * 10 + i) > 22) break;
          var mapSprite = Sprite(
              'cards/items02.jpg', x: ((i - 1) * 565).toDouble(),
              y: ((j - 1) * 1080).toDouble(),
              width: 565,
              height: 1080);
          //继续前面的计数
          itemsmap.putIfAbsent((j - 1) * 10 + i + 11, () =>
              ItemsCard(this, mapSprite, leftoffset, (j - 1) * 10 + i + 11));
        }
      }
    }

    //初始化事件
    void initEvents() {
      for (int j = 1; j <= 5; j++) {
        for (int i = 1; i <= 10; i++) {
          if (((j - 1) * 10 + i) > 45) break; //图片上只有45张卡片
          var mapSprite = Sprite(
              'cards/events01.jpg', x: ((i - 1) * 565).toDouble(),
              y: ((j - 1) * 1080).toDouble(),
              width: 565,
              height: 1080);
          //继续前面的计数
          eventsmap.putIfAbsent((j - 1) * 10 + i, () =>
              EventsCard(this, mapSprite, leftoffset, (j - 1) * 10 + i));
        }
      }

      for (int j = 1; j <= 2; j++) {
        for (int i = 1; i <= 10; i++) {
          if (((j - 1) * 10 + i) > 11) break; //图片上只有45张卡片
          var mapSprite = Sprite(
              'cards/events02.jpg', x: ((i - 1) * 565).toDouble(),
              y: ((j - 1) * 1080).toDouble(),
              width: 565,
              height: 1080);
          //继续前面的计数
          eventsmap.putIfAbsent((j - 1) * 10 + i + 45, () =>
              EventsCard(this, mapSprite, leftoffset, (j - 1) * 10 + i + 45));
        }
      }
    }

    //初始化预兆
    void initOmens() {
      for (int j = 1; j <= 2; j++) {
        for (int i = 1; i <= 10; i++) {
          if (((j - 1) * 10 + i) > 13) break; //图片上只有45张卡片
          var mapSprite = Sprite(
              'cards/omen01.jpg', x: ((i - 1) * 565).toDouble(),
              y: ((j - 1) * 1080).toDouble(),
              width: 565,
              height: 1080);
          //继续前面的计数
          omensmap.putIfAbsent((j - 1) * 10 + i, () =>
              OmensCard(this, mapSprite, leftoffset, (j - 1) * 10 + i));
        }
      }

      for (int j = 1; j <= 1; j++) {
        for (int i = 1; i <= 10; i++) {
          if (((j - 1) * 10 + i) > 8) break; //图片上只有45张卡片
          var mapSprite = Sprite(
              'cards/omen02.jpg', x: ((i - 1) * 565).toDouble(),
              y: ((j - 1) * 1080).toDouble(),
              width: 565,
              height: 1080);
          //继续前面的计数
          omensmap.putIfAbsent((j - 1) * 10 + i + 13, () =>
              OmensCard(this, mapSprite, leftoffset, (j - 1) * 10 + i + 11));
        }
      }
    }

}
