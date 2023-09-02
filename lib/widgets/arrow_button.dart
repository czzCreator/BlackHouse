//箭头按钮
import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final void Function() onTap;
  final String direction;   //方向 1:向左 2：向上 3： 向右 4：向下
  final bool isopen;

  const ArrowButton({Key key, this.onTap, this.direction,this.isopen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String imageUrl="";
    if(direction=="left")
      {
        if(isopen) imageUrl="assets/images/left_arrow_open.png";
        else imageUrl="assets/images/left_arrow.png";
      }
    else if(direction=="up")
      {
        if(isopen) imageUrl="assets/images/up_arrow_open.png";
        else imageUrl="assets/images/up_arrow.png";
      }
    else if(direction=="right")
    {
      if(isopen) imageUrl="assets/images/right_arrow_open.png";
      else imageUrl="assets/images/right_arrow.png";
    }
    else if(direction=="down")
    {
      if(isopen) imageUrl="assets/images/down_arrow_open.png";
      else imageUrl="assets/images/down_arrow.png";
    }

    return SizedBox(
      height: direction=="left"||direction=="right"?30:45,width: direction=="left"||direction=="right"?45:30,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.fill,
            )),
        child: GestureDetector(
          child:Container(
              height: direction=="left"||direction=="right"?30:45,width: direction=="left"||direction=="right"?45:30,
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