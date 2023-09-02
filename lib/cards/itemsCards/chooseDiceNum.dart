import 'package:flutter/material.dart';
import 'package:blackhouse/config/param.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:blackhouse/game/blackhousegame.dart';

class ChooseNum extends StatefulWidget {
  int type;
  List<int> Nums;
  BlackHouseGame blackhouseGame;
  ChooseNum(this.type,this.Nums,this.blackhouseGame);
  @override
  ChooseNumState createState() => new ChooseNumState();
}

class ChooseNumState extends State<ChooseNum> {

  Map<int, bool> values = {};

  @override
  void initState() {
    // TODO: implement initState
      for (int i = 0; i < widget.Nums.length; i++) {
        values.putIfAbsent(widget.Nums[i], () => false);
      }
      chooseNum = -1;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      height: ScreenUtil().setSp(190),
      width: ScreenUtil().setSp(420),
          child:  ListView(
        children: values.keys.map((int key) {
          return new CheckboxListTile(
            title: widget.type==1?Text("${key}")
                :widget.type==2?Text("${widget.blackhouseGame.maps[key].roomname}")
                :widget.type==3?Text("${widget.blackhouseGame.persons[key].playername}")
                 :Text("${shuxinglist[key]}"),
            value: values[key],
            onChanged: (bool value) {
              for(int i=0;i<=widget.Nums.length;i++)
              {
                if(i!=key)
                values[i]=false;
              }
              values[key] = true;
              chooseNum=key;
              setState(() {

              });
            },
          );
        }).toList(),
      ),
    );
  }


}
