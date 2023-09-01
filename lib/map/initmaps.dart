//初始化67块地图信息
import 'package:flutter/cupertino.dart';
import 'mapBlock.dart';

//dart是值传递，传过来的对象直接编辑
void initMaps(Map<int,Mapblock> maps)
{
  Offset _initOffset=Offset(-99, -99);
  //1号地图块：上台阶-连接楼上
  maps[1]!.initMapRoom(
      '上台阶',
      '连接楼上',
      'L','O','R','O',       //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,false,false,2,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      Offset(-2,0),_initOffset,Offset(0,0));     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //2号房间地图块：门厅
  maps[2]!.initMapRoom(
      '门厅',
      '',
      'L','U','R','D',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,false,false,2,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      Offset(-1,0),_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //3号房间地图块：入口大厅
  maps[3]!.initMapRoom(
      '入口大厅',
      '',
      'L','U','O','D',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,false,false,2,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      Offset(0,0),_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标


  //4号房间块：上层
  maps[4]!.initMapRoom(
      '上层',
      '',
      'L','U','R','D',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,false,3,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      Offset(0,0),Offset(-2,0),_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //5号房间块：地下室
  maps[5]!.initMapRoom(
      '地下室',
      '',
      'L','U','R','D',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,1,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //6号房间块：腐朽的走廊
  maps[6]!.initMapRoom(
      '腐朽的走廊',
      '',
      'L','U','R','D',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //7号房间块：尘封的走廊
  maps[7]!.initMapRoom(
      '尘封的走廊',
      '',
      'L','U','R','D',       //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //8号房间块：游戏室
  maps[8]!.initMapRoom(
      '游戏室',
      '',
      'O','U','R','D',     //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //9号房间块：破烂房间
  maps[9]!.initMapRoom(
      '破烂房间',
      '离开时必须进行力量检测达到3+\n如果失败了失去1点速度\n然后继续移动',
      'L','U','R','D',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //10号房间块：神秘电梯
  maps[10]!.initMapRoom(
      '神秘电梯',
      '每回合一次\n掷两个骰子将这个房间移动到任意开着的门口\n4:任意楼层\n3:上层\n2:地面\n1:地下室\n0:地下室并受到1点地下室伤害',
      'O','U','O','O',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //11号房间块：风琴室
  maps[11]!.initMapRoom(
      '风琴室',
      '',
      'L','O','O','D',     //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //12号房间块：雕塑长廊
  maps[12]!.initMapRoom(
      '雕塑长廊',
      '',
      'O','U','O','D',     //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //13号房间块：健身房
  maps[13]!.initMapRoom(
      '健身房',
      '如果在回合结束时你停留在这个房间内\n放置一枚你的冒险者标记并提升1级速度\n每人每局游戏一次',
      'O','O','R','D',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //14号房间块：手术室
  maps[14]!.initMapRoom(
      '手术室',
      '',
      'O','O','R','D',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //15号房间块：研究室
  maps[15]!.initMapRoom(
      '研究室',
      '',
      'O','U','O','D',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //16号房间块：佣人房
  maps[16]!.initMapRoom(
      '佣人房',
      '',
      'L','U','R','D',       //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //17号房间块：储藏室
  maps[17]!.initMapRoom(
      '储藏室',
      '',
      'O','U','O','O',     //初始化门的四个参数
      1,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //18号房间块：金库
  maps[18]!.initMapRoom(
      '金库',
      '你可以尝试进行知识检定\n达到6+可以打开并拿走东西\n并放置金库已孔的标志在上面',
      'O','U','O','O',      //初始化门的四个参数
      2,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //19号房间块：阁楼
  maps[19]!.initMapRoom(
      '阁楼',
      '离开时你必须进行速度检定达到3+\n如果失败减少1点力量\n继续行动',
      'O','O','O','D',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //20号房间块：露台
  maps[20]!.initMapRoom(
      '露台',
      '',
      'O','U','O','D',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //21号房间块：卧室
  maps[21]!.initMapRoom(
      '卧室',
      '',
      'L','O','R','O',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //22号房间块：画廊
  maps[22]!.initMapRoom(
      '画廊',
      '如果你已经发现舞厅\n你可以选择掉到那里\n并收到1骰子的物理伤害',
      'O','U','O','D',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //23号房间块：主人卧室
  maps[23]!.initMapRoom(
      '主人卧室',
      '',
      'L','U','O','O',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //24号房间块：塔楼
  maps[24]!.initMapRoom(
      '塔楼',
      '你可以进行力量检测达到3+通过这里\n如果失败了，停止移动',
      'L','O','R','O',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //25号房间块：带血的房间
  maps[25]!.initMapRoom(
      '带血的房间',
      '',
      'L','U','R','D',      //初始化门的四个参数
      1,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //26号房间块：礼拜堂
  maps[26]!.initMapRoom(
      '礼拜堂',
      '如果在回合结束时你停留在这个房间内\n放置一枚你的冒险者标志并提升1级神志\n每人每局游戏一次',
      'O','U','O','O',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //27号房间块：熏黑的房间
  maps[27]!.initMapRoom(
      '熏黑的房间',
      '',
      'L','U','R','D',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //28号房间块：坍塌的房间
  maps[28]!.initMapRoom(
      '坍塌的房间',
      '你必须进行速度检测达到5+防止坠落\n如果失败抽取一张地下室房间放置合适位置\n将\'坍塌的房间下面\'标志放在那里\n你掉落在那里并受到1骰子的物理伤害',
      'L','U','R','D',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //29号房间块：温室
  maps[29]!.initMapRoom(
      '温室',
      '',
      'O','U','O','O',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //30号房间块：图书馆
  maps[30]!.initMapRoom(
      '图书馆',
      '如果在回合结束时你停留在这个房间内\n放置一枚你的冒险者标志并提升1级知识\n每人每局游戏一次',
      'L','O','O','D',     //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //31号房间块：舞厅
  maps[31]!.initMapRoom(
      '舞厅',
      '',
      'L','U','R','D',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //32号房间块：导煤槽
  maps[32]!.initMapRoom(
      '导煤槽',
      '单向滑向地下室',
      'O','U','O','O',     //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //33号房间块：餐厅
  maps[33]!.initMapRoom(
      '餐厅',
      '',
      'O','U','R','O',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //34号房间块：花园
  maps[34]!.initMapRoom(
      '花园',
      '',
      'O','U','O','D',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //35号房间块：墓园
  maps[35]!.initMapRoom(
      '墓园',
      '离开时你必须进行神志检定达到4+\n如果失败了失去1点知识\n然后继续移动',
      'O','O','O','D',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //36号房间块：天井
  maps[36]!.initMapRoom(
      '天井',
      '',
      'L','U','O','D',     //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //37号房间块：废弃的房间
  maps[37]!.initMapRoom(
      '废弃的房间',
      '',
      'L','U','R','D',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //38号房间块：厨房
  maps[38]!.initMapRoom(
      '厨房',
      '',
      'O','U','R','O',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //39号房间块：墓穴
  maps[39]!.initMapRoom(
      '墓穴',
      '你可以尝试神志检定达到6+来通过\n如果失败了，停留在这里',
      'O','U','O','D',     //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //40号房间块：深渊
  maps[40]!.initMapRoom(
      '深渊',
      '你可以尝试速度检定达到3+来通过\n如果失败了，停留在这里',
      'L','O','R','O',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //41号房间块：地窖
  maps[41]!.initMapRoom(
      '地窖',
      '如果在回合结束时你停留在这里\n受到1点精神伤害',
      'O','U','O','O',     //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //42号房间块：锅炉房
  maps[42]!.initMapRoom(
      '锅炉房',
      '如果在回合结束时你停留在这里\n受到1点物理伤害',
      'L','U','O','D',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //43号房间块：食物橱
  maps[43]!.initMapRoom(
      '食物橱',
      '如果在回合结束时你停留在这个房间内\n放置一枚你的冒险者标志并提升1级力量\n每人每局游戏一次',
      'O','U','O','D',      //初始化门的四个参数
      1,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //44号房间块：五芒星堂
  maps[44]!.initMapRoom(
      '五芒星堂',
      '离开时你必须进行知识检定达到4+\n如果失败了失去1点神志\n然后继续移动',
      'O','O','R','O',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //45号房间块：地下室的楼梯
  maps[45]!.initMapRoom(
      '地下室的楼梯',
      '',
      'O','U','O','D',     //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //46号房间块：地下湖
  maps[46]!.initMapRoom(
      '地下湖',
      '',
      'O','U','R','O',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //47号房间块：酒窖
  maps[47]!.initMapRoom(
      '酒窖',
      '',
      'O','U','O','D',     //初始化门的四个参数
      1,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //-----------------------------------------------------拓展地图------------------------------------------------------

  //48号房间块：顶层
  maps[48]!.initMapRoom(
      '顶层',
      '初始设置时放置的版块之一\n与上层相连\n任何可以放置在上层的房间都可以放置在这一层',
      'L','U','R','D',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,false,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //49号房间块：避难所
  maps[49]!.initMapRoom(
      '避难所',
      '当你离开时\n你可以进行一次3+速度考验\n如果通过考验移动到任意带电梯标志的房间',
      'L','O','O','O',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //50号房间块：旋转楼梯
  maps[50]!.initMapRoom(
      '旋转楼梯',
      '你可以花费2点移动值，前往任一楼层的起点',
      'L','U','R','D',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //51号房间块：书房
  maps[51]!.initMapRoom(
      '书房',
      '如果在回合结束时你停留在这个房间内\n放置一枚你的冒险者标志并提升1级精神\n每人每局游戏一次',
      'O','O','R','D',      //初始化门的四个参数
      0,1,0,1,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //52号房间块：上锁的房间
  maps[52]!.initMapRoom(
      '上锁的房间',
      '在这个房间的每个门上放置一个门锁标记\n想要进入或者离开锁着的门时\n进行一次3+的知识考验并解除门锁',
      'O','U','R','D',     //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //53号房间块：会客厅
  maps[53]!.initMapRoom(
      '会客厅',
      '当这个房间被发现时，抽取一张任意类型的卡牌',
      'L','U','R','D',      //初始化门的四个参数
      0,0,0,1,1,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //54号房间块：婴儿房
  maps[54]!.initMapRoom(
      '婴儿房',
      '如果回合结束时你停留在这里\n你的神志低于初始值时增加1点\n高于初始值时减少1点',
      'O','U','R','O',     //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //55号房间块：缝纫室
  maps[55]!.initMapRoom(
      '缝纫室',
      '如果回合结束时你停留在这里\n你可以丢掉一件物品增加1点物理考验\n如果它低于初始值的话',
      'L','U','R','D',      //初始化门的四个参数
      1,0,0,1,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //56号房间块：日光浴室
  maps[56]!.initMapRoom(
      '日光浴室',
      '如果回合结束时你停留在这里\n你可以丢掉一件道具增加1点神志',
      'O','U','O','O',     //初始化门的四个参数
      1,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //57号房间块：漫步天台
  maps[57]!.initMapRoom(
      '漫步天台',
      '在这里考研知识时，掷骰结果加1\n考验速度时，掷骰结果减1(最低为0)',
      'L','O','R','D',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,true,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //58号房间块：鸟舍
  maps[58]!.initMapRoom(
      '鸟舍',
      '当这个房间被放置时\n检索房间牌堆人选一个放在符合条件的位置\n然后切洗房间牌堆',
      'L','O','R','O',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,false,true,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //59号房间块：盥洗室
  maps[59]!.initMapRoom(
      '盥洗室',
      '',
      'O','O','O','D',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,true,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //60号房间块：剧院
  maps[60]!.initMapRoom(
      '剧院',
      '',
      'L','O','R','O',      //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,true,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //61号房间块：树屋
  maps[61]!.initMapRoom(
      '树屋',
      '将一个植物标记放置在阁楼或者上层任意开启的门上，这个房间将与之相连',
      'L','O','O','D',     //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //62号房间块：军火室
  maps[62]!.initMapRoom(
      '军火室',
      '当你在这个房间抽取物品卡时，抽取两张，选择一张并弃掉另一张',
      'O','O','R','D',      //初始化门的四个参数
      1,0,0,1,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //63号房间块：洗衣房
  maps[63]!.initMapRoom(
      '洗衣房',
      '如果在回合结束时你停留在这个房间内\n你可以选择弃掉一件物品\n然后在物品弃堆中抽取一张',
      'L','O','O','D',      //初始化门的四个参数
      1,0,0,1,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //64号房间块：兽栏
  maps[64]!.initMapRoom(
      '兽栏',
      '如果在回合结束时你停留在这个房间内\n放置一枚你的冒险者标志并提升1级物理属性\n每人每局游戏一次',
      'L','O','R','O',      //初始化门的四个参数
      0,1,0,1,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,true,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //65号房间块：洞穴
  maps[65]!.initMapRoom(
      '洞穴',
      '如果你在回合内进入并离开这个房间，掷一个骰减少物理属性',
      'L','U','R','D',      //初始化门的四个参数
      0,1,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //66号房间块：地牢
  maps[66]!.initMapRoom(
      '地牢',
      '进入房间进行一次3+神志考验\n如果失败，减少1点神志',
      'O','U','O','D',       //初始化门的四个参数
      0,0,1,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //67号房间块：防风地窖
  maps[67]!.initMapRoom(
      '防风地窖',
      '',
      'O','O','R','D',      //初始化门的四个参数
      1,0,0,1,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      true,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  //100、101黑色地图块
  maps[100]!.initMapRoom(
      '黑色块100',
      '',
      'O','O','O','O',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

  maps[101]!.initMapRoom(
      '黑色块101',
      '',
      'O','O','O','O',      //初始化门的四个参数
      0,0,0,0,0,       //物品、事件、征兆、电梯、任意抽卡标志五个参数
      false,false,false,false,0,   //可放置地下室，可放置地面，可放置二楼，可放置顶楼，当前楼层五个参数（0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼）
      _initOffset,_initOffset,_initOffset);     //本层坐标，连接下层的房间坐标，连接上层的房间坐标

}
