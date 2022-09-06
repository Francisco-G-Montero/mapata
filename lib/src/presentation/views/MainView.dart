import 'package:flutter/material.dart';
import 'package:mapata/src/data/util/Constants.dart';
import 'package:mapata/src/presentation/views/HomeView.dart';
import 'package:mapata/src/presentation/views/ProfileView.dart';
import 'package:mapata/src/presentation/widgets/AppBarWidget.dart';
import 'package:mapata/src/presentation/widgets/NavigationDrawerWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainView();
}

class _MainView extends State<MainView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBarWidget(kAppTitle, 55),
      drawer: NavigationDrawerWidget(),
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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: locale.navigation_home),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: locale.navigation_profile),
        ],
      ),
    );
  }
}