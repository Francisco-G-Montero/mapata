import 'package:flutter/material.dart';

enum TabItem { home, profile }

const Map<TabItem, String> tabName = {
  TabItem.home: 'home',
  TabItem.profile: 'profile',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.home: Colors.red,
  TabItem.profile: Colors.green,
};
