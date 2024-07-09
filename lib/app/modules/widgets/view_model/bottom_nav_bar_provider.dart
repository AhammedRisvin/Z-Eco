import 'package:flutter/material.dart';

import '../../../utils/prefferences.dart';
import '../../flicks/view/ficks_screen.dart';
import '../../home/view/home_screen.dart';
import '../../orders/view/orders_screen.dart';
import '../../settings/view/settings_screen.dart';
import '../../vibes/view/vibes_home_screen.dart';

class BottomBarProvider extends ChangeNotifier {
  int selectedIndex = 0;

  bool isSignedIn = AppPref.isSignedIn;

  final List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const VibesHomeScreen(),
    const FlicksScreen(), //FlicksScreen
    const OrdersScreen(),
    const SettingsScreen(),
  ];

  void onItemTapped({required int index, bool isTap = false}) {
    selectedIndex = index;

    notifyListeners();
  }
}
