
import 'package:flutter/material.dart';

class CustomNaviBarMenu{
  final String title;
  final int id;
  final IconData icon;

  CustomNaviBarMenu({required this.title,required this.id,required this.icon});
}

class NaviBarSubMenu{
  final String title;
  final int rootId;
  final int id;

  NaviBarSubMenu({required this.title,required this.rootId,required this.id});
}
