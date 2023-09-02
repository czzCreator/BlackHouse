import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blackhouse/config/param.dart';
import 'package:blackhouse/tools/cardstools.dart';


//还要加个倒计时
class DamageChooseWidget extends StatefulWidget {
  var DamageNum_1;
  var DamageNum_2;
  String text_1;
  String text_2;
  int DamageNum_total;
  DamageChooseWidget(this.DamageNum_1,this.DamageNum_2,this.text_1,this.text_2,this.DamageNum_total);
  @override
  _DamageChooseWidgetState createState() => _DamageChooseWidgetState(this.DamageNum_1,this.DamageNum_2,this.text_1,this.text_2,this.DamageNum_total);
}

class _DamageChooseWidgetState extends State<DamageChooseWidget> {
  var DamageNum_1;
  var DamageNum_2;
  String text_1;
  String text_2;
  int DamageNum_total;

  int orgDamageNum_1;
  int orgDamageNum_2;
  _DamageChooseWidgetState(this.DamageNum_1,this.DamageNum_2,this.text_1,this.text_2,this.DamageNum_total);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orgDamageNum_1=DamageNum_1;
    orgDamageNum_2=DamageNum_2;

    numAfterDamage_1=DamageNum_1;
    numAfterDamage_2=DamageNum_2;
    numTotalAfterDamage=DamageNum_total;

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: ScreenUtil().setHeight(100),
      child: Column(
        children: [
          Text("请分配精神伤害点数,剩余点数:$DamageNum_total",style: TextStyle(
            color: Colors.lightBlue,
            fontSize: ScreenUtil().setSp(20),
          ),),
          Expanded(child: new Text(" ")),
         Row(
        children: [
          new GestureDetector(
            child: Container(
              width: 20,
              height: 20,
              child: Icon(Icons.remove),
            ),
            //不写的话点击起来不流畅
            onTap: () {
                if (DamageNum_1 < 1||DamageNum_total<1) {
                  showToast("无法继续减小");
                  return;
                }
                DamageNum_1--;
                DamageNum_total--;
                numAfterDamage_1=DamageNum_1;
                numTotalAfterDamage=DamageNum_total;

                setState(() {
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              child: Text(
                '$text_1:$DamageNum_1',
                style: TextStyle(color: Color(0xff333333), fontSize: 15),
              ),
            ),
          ),
          new GestureDetector(
            child: Container(
              width: 20,
              height: 20,
              child: Icon(Icons.add),
            ),
            onTap: () {
                if (DamageNum_1 >=orgDamageNum_1) {
                  showToast("无法增加属性点大于原属性点");
                  return;
                }
                DamageNum_1++;
                DamageNum_total++;
                numAfterDamage_1=DamageNum_1;
                numTotalAfterDamage=DamageNum_total;

                setState(() {
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 50),
            child: Align(
              child: Text(
                '        ',
                style: TextStyle(color: Color(0xff333333), fontSize: 15),
              ),
            ),
          ),
          new GestureDetector(
            child: Container(
              width: 20,
              height: 20,
              child: Icon(Icons.remove),
            ),
            //不写的话点击起来不流畅
            onTap: () {
                if (DamageNum_2 < 1||DamageNum_total<1) {
                  showToast("无法继续减小");
                  return;
                }
                DamageNum_2--;
                DamageNum_total--;

                numAfterDamage_2=DamageNum_2;
                numTotalAfterDamage=DamageNum_total;

                setState(() {
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              child: Text(
                '$text_2:$DamageNum_2',
                style: TextStyle(color: Color(0xff333333), fontSize: 15),
              ),
            ),
          ),
          new GestureDetector(
            child: Container(
              width: 20,
              height: 20,
              child: Icon(Icons.add),
            ),
            onTap: () {

                if (DamageNum_2 >=orgDamageNum_2) {
                  showToast("无法增加属性点大于原属性点");
                  return;
                }
                DamageNum_2++;
                DamageNum_total++;

                numAfterDamage_2=DamageNum_2;
                numTotalAfterDamage=DamageNum_total;
                setState(() {
              });
            },
          ),
        ],
      ),
    ]));
  }

}
