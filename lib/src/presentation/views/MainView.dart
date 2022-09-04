import 'package:flutter/material.dart';
import 'package:mapata/src/presentation/navigation/BottomNavigation.dart';
import 'package:mapata/src/presentation/navigation/TabItem.dart';
import 'package:mapata/src/presentation/navigation/TabNavigator.dart';
import 'package:mapata/src/presentation/views/HomeView.dart';
import 'package:mapata/src/presentation/views/ProfileView.dart';

class MainView extends StatefulWidget {
  const MainView();

  @override
  State<MainView> createState() => _MainView();
}

class _MainView extends State<MainView> {
  TabItem currentTab = TabItem.home;
  int currentIndex = 0;
  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: currentIndex != 0,
            child: HomeView(),
          ),
          Offstage(
            offstage: currentIndex != 1,
            child: ProfileView(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;     /// Switching tabs
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Text("1"), label: "Tab 1"),
          BottomNavigationBarItem(icon: Text("2"), label: "Tab 2"),
        ],
      ),
    );
  }
}