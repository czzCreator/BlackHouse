//房间中间的下楼箭头按钮
import 'package:flutter/material.dart';

class MiddleArrowButton extends StatelessWidget {
  final void Function() onTap;

  const MiddleArrowButton({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:45,width: 30,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/middle_arrow.png"),
              fit: BoxFit.fill,
            )),
        child: GestureDetector(
          child:Container(
              height:45,width: 30,
              child:Text("",
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 1,
                  fontWeight: FontWeight.bold,
                ),)
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}