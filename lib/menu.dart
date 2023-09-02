//主界面菜单页面，创建房间，及加入房间的主界面
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:blackhouse/utlis/sounds.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blackhouse/game.dart';


class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(1334, 750), allowFontScaling: false);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child:  buildMenu(),
    );
  }

  Widget buildMenu() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
              padding: EdgeInsets.only(top:  ScreenUtil().setSp(500)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  creatRoom(),  //创建房间
                  joinRoom(),  //加入房间
                  invitation(),//邀请好友
                  searchRoom(),//搜索房号
                ],
              )),
        ),
      ),

    );
  }

  Widget creatRoom()
  {
    return Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setHeight(60),
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
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Game()),
                (Route<dynamic> route) => false,
          );
        },
        child: Text("创建房间"),
        color: Colors.transparent,
      ),
    );
  }

  Widget joinRoom()
  {
    return Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setHeight(60),
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
        { print("bbb");
        },
        child: Text("快速加入"),
        color: Colors.transparent,
      ),
    );
  }

  Widget  invitation()
  {
    return Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setHeight(60),
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
        { print("ccc");
        },
        child: Text("邀请好友"),
        color: Colors.transparent,
      ),
    );
  }

  Widget  searchRoom()
  {
    return Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setHeight(60),
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
        { print("ccc");
        },
        child: Text("搜索房号"),
        color: Colors.transparent,
      ),
    );
  }

}
