import 'package:blackhouse/game/blackhousegame.dart';
import 'package:blackhouse/persons/person.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blackhouse/config/param.dart';
import 'package:blackhouse/tools/cardstools.dart';


//还要加个倒计时(by hxd)
class DamageChooseAllWidget extends StatefulWidget {
  Person person;
  List list;

  DamageChooseAllWidget(this.person,this.list);

  @override
  DamageChooseAllWidgetState createState() => DamageChooseAllWidgetState();
}

class DamageChooseAllWidgetState extends State<DamageChooseAllWidget> {
  List<Row> _list = new List();
  DamageChooseAllWidgetState();
  static int chose = -1;
  @override
  void initState() {
    super.initState();
    if(widget.list==null||widget.list.length==0){
      if(widget.person.currentspeed>1){
        chose = 1;
      }else if(widget.person.currentmight>1){
        chose = 2;
      }else if(widget.person.currentsanity>1){
        chose = 3;
      }else if(widget.person.currentknowledge>1){
        chose = 4;
      }
    }else{
      chose = 1;
      _list.add(new Row(
        children: [
          Text("请选择一项属性来进行检定",style: TextStyle(
            color: Colors.lightBlue,
            fontSize: ScreenUtil().setSp(20),),
          ),
        ],
      ));
      for(int i=0;i<widget.list.length-1;i++){
        if(i%2==0){
          _list.add(new Row(
            children: [
              _container(i+1, widget.list[i]),
              _container(i+2, widget.list[i+1]),
            ],
          ));
        }
      }
      if(widget.list.length%2==1){
        _list.add(new Row(
          children: [
            _container(widget.list.length, widget.list[widget.list.length-1]),
          ],
        ));
      }
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setSp(190),
        width: ScreenUtil().setSp(420),
        child: widget.list==null||widget.list.length==0?Column(
            children: [
              Row(
                children: [
                  Text("请选择一项属性来进行检定",style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: ScreenUtil().setSp(20),),
                  ),
                ],
              ),
              Row(
                children: [
                  _container(1, "速度 ${widget.person.currentspeed}"),
                  _container(2, "力量 ${widget.person.currentmight}"),
                ],
              ),
              Row(
                children: [
                  _container(3, "神志 ${widget.person.currentsanity}"),
                  _container(4, "知识 ${widget.person.currentknowledge}"),
                ],
              )
            ]
        ):ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context,index){
            return _list[index];
          },
        )
    );
  }

  Container _container(int i,String title){
    return Container(
      width: ScreenUtil().setSp(210),
      height: ScreenUtil().setSp(80),
      child: RadioListTile(
        onChanged: (v) async{
          if(widget.list!=null&&widget.list.length>0){
            setState(() {
              int a = (i-1)~/2+1;
              bool b = (i-1)%2==0;
              chose = i;
              _list[a] = new Row(
                children: [
                  _container(a, widget.list[b?i-1:i-2]),
                  _container(a+1, widget.list[b?i:i-1]),
                ],
              );
            });
          }else{
            if(int.parse(title.substring(3))<1){
              await showToast("该属性以为最低级");
            }else{
              setState(() {
                chose = i;
              });
            }
          }
        },
        value: i,
        title: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
        groupValue: chose,
      ),
    );
  }

}
