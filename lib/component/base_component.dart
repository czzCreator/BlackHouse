import 'package:flutter/material.dart';

abstract class BaseComponent{
  void render(Canvas canvas);
  void update(double t);
}