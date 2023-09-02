//骰子按钮
import 'package:flutter/material.dart';

class PNGButton extends StatelessWidget {
  final String imagepath;
  final void Function() onTap;

  const PNGButton({Key key, this.onTap,this.imagepath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,width: 90,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagepath),
              fit: BoxFit.fill,
            )),
        child: GestureDetector(
          child:Container(
            decoration: BoxDecoration(
              //color: Color(0x88ffffff),
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}