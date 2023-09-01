import 'dart:io';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blackhouse/utlis/localization/my_localizations_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:blackhouse/menu.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  loadAssets();
  bool isWeb = false;
  try{
    if(Platform.isAndroid || Platform.isIOS){
      isWeb = false;
    }else{
      isWeb = true;
    }
  }catch(e){
    isWeb = true;
  }

  if(! isWeb){
    ///设置横屏
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);

    ///全面屏
    await SystemChrome.setEnabledSystemUIOverlays([]);
  }
  MyLocalizationsDelegate myLocation = const MyLocalizationsDelegate();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Normal',
      ),
      home: Menu(),
      supportedLocales: MyLocalizationsDelegate.supportedLocales(),
      localizationsDelegates: [
        myLocation,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: myLocation.resolution,
    ),
  );

}

void loadAssets(){
  Flame.images.loadAll([
    'bg.jpg',
    'gamebg.webp',
    'toolrect.png',
    'dice.png',
    'mpIcon.png',
    'left_arrow.png',
    'right_arrow.png',
    'up_arrow.png',
    'down_arrow.png',
    'left_arrow_open.png',
    'right_arrow_open.png',
    'up_arrow_open.png',
    'down_arrow_open.png',
    'middle_arrow.png',
    'maps/Rooms1.jpg',
    'maps/Rooms2.jpg',
    'maps/startRooms.png',
    'menu/button.png',
    'persons/person1.png',
    'persons/person2.png',
    'persons/person3.png',
    'persons/person4.png',
    'persons/person5.png',
    'persons/person6.png',
    'cards/items01.jpg',
    'cards/items02.jpg',
    'cards/events01.jpg',
    'cards/events02.jpg',
    'cards/omen01.jpg',
    'cards/omen02.jpg'
  ]);
}

