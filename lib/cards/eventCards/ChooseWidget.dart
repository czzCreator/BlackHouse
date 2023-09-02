import 'package:blackhouse/game/blackhousegame.dart';
import 'package:blackhouse/persons/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blackhouse/tools/cardstools.dart';

//还要加个倒计时(by hxd)
class ChooseWidget extends StatefulWidget {
  String title;

  ChooseWidget(this.title);

  @override
  _ChooseWidgetState createState() => _ChooseWidgetState();
}

class _ChooseWidgetState extends State<ChooseWidget> {
  _ChooseWidgetState();
  static int chose = -1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(widget.title,style: TextStyle(
          color: Colors.lightBlue,
          fontSize: ScreenUtil().setSp(20),),
        ),
    );
  }
}
