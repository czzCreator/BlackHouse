int numAfterDamage_1=0;  //减少后的属性1
int numAfterDamage_2=0;  //减少后的属性2
int numTotalAfterDamage=0;  //受的总伤害

int templeftid=0;     //临时左边房间ID存放
int tempmiddleid=0;   //临时中间房间ID存放
int temprightid=0;    //临时右边房间ID存放
int choosedMapID=0;   //从小地图选中的mapid
int chooseMapDoor=0;  //从小地图选中的门， 左1  上2  右3 下4
bool  ischooseroom=false;   //是否选取小地图房间
bool  ischooseRoomDoor=false;  //是否选取地图的门
int  chooseplayer=0;   //选取的玩家
int  setChooseOpenRoom=0;    //指定将要翻开的房间id
int  eventcardId=0;

int chooseNum=-1;
List<String> shuxinglist=["力量","速度","神志","知识"];