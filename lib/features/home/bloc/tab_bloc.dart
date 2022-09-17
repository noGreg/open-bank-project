import 'package:flutter/material.dart';

import '../models/app_bottom_tab.dart';

class TabBloc extends ChangeNotifier {
  TabBloc() : super() {
    // onUpdateTab(AppBottomTab.home);
    currentTab = AppBottomTab.home;
  }
  late AppBottomTab currentTab;

  void onUpdateTab(AppBottomTab tab) {
    currentTab = tab;
    notifyListeners();
  }
}
