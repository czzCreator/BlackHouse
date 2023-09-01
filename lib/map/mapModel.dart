//地图的通用属性定义文件General attribute definition file for map

import 'dart:ui';

abstract class MapModel {

  int mapid=-99;
  String roomname="";  //房间名
  String rules="";     //房间规则

  String mapSprite="";
  //摆放位置
  Offset position=Offset(-99, -99);

  //当前地图块是否展现
  bool isshow=false;
  //地图块最后展现位置，未了切换用户场景时用到  0: 未放置  1：左边   2：中间   3：右边
  int lastlocation=0;
  //是否被翻开
  bool isopen=false;
  //当前地图块左门, 按原图顺时针的左，上，右，下，分别定义为门'L'，'U'，'R'，'D', 不存在为0
  String leftdoor='L';
  String updoor='U';
  String rightdoor='R';
  String downdoor='D';

  //旋转角度  0 保持素材的角度，90：顺时针90度  180：顺时针180度   270： 顺时针270度
  //对应的门的编号也变化，例如90度时， leftdoor=4, updoor=1, rightdoor=2 ,downdoor=3
  int 	rotationAngle=0;
  //地图块中的玩家队列
  List<int> playerlist=[];
  //事件牌list
  List<int> eventslist=[];
  //物品牌list
  List<int> itemslist=[];
  //征兆牌list
  List<int> omenslist=[];
  //地图块中间通向的房间，适用于上下楼
  Offset themiddleuproom=Offset(-99, -99);
  Offset themiddledownroom=Offset(-99, -99);

  //预兆标志个数，根据房间属性初始化，如果有翻开房间后归0
  int omenflags=0;
  //事件标志个数，根据房间属性初始化，如果有翻开房间后归0
  int eventflags=0;
  //物品标志个数，根据房间属性初始化，如果有翻开房间后归0
  int itemflags=0;
  //电梯标志,根据房间属性初始化，如果有翻开房间后有标志固定未1
  int liftflags=0;
  //任意抽卡标志,根据房间属性初始化，如果有翻开房间后归0
  int randomflags=0;
  //是否可放置地下室
  bool ifsetunderground=false;
  //是否可放置一楼
  bool ifsetground=false;
  //是否可放置二楼
  bool ifsetupground=false;
  //是否可放置顶楼
  bool ifsettopground=false;
  //当前被放置层数, 0:未放置， 1：地下室， 2：地面， 3：二楼 ， 4：顶楼
  int currentlayer=0;
  //地图横纵坐标,结合layer
  Offset coordinate=Offset(-99,-99);
  double maprate=1;    //地图缩放比，小地图为0.2


//判定要用的骰子数目
  int dicenum=0;
  //祝福标记
  int zhufuflag=0;
  //壁橱标记
  int bichuflag=0;
  //滴答标记
  int tickflag=0;
  //保险箱标记
  int strongboxflag=0;
  //滑梯上端标记
  int huatiupflag=0;
  //滑梯上端标记
  int huatidownflag=0;
  //骸骨标记
  int boneflag=0;
  //墙壁开关标记
  int openwallflag=0;
  //秘密通道标记
  int secretwayflag=0;
  //秘密楼梯标记
  int secretstairsflag=0;
  //烟雾标记
  int smokeflag=0;
  //冢标记
  int tombsflag=0;
  //植物标记
  int plantflag=0;


}
