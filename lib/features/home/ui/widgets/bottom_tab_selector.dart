import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_bank_project/core/extensions/responsive.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/strings.dart';
import '../../bloc/tab_bloc.dart';
import '../../models/app_bottom_tab.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';

class BottomTabSelector extends StatelessWidget {
  const BottomTabSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: context.select((TabBloc tab) => tab.currentTab.index),
        onTap: (index) => _onTapItem(AppBottomTab.values[index], context),
        items: AppBottomTab.values
            .map((tab) => _getBarItem(tab, context))
            .toList());
  }

  void _onTapItem(AppBottomTab activeTab, BuildContext context) {
    context.read<TabBloc>().onUpdateTab(activeTab);
    switch (activeTab) {
      case AppBottomTab.profile:
        return _pushNamedRoute(context, ProfileScreen.routeName);

      case AppBottomTab.home:
        return _pushNamedRoute(context, HomeScreen.routeName);
      default:
        _pushNamedRoute(context, HomeScreen.routeName);

        break;
    }
  }

  void _pushNamedRoute(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  BottomNavigationBarItem _getBarItem(AppBottomTab tab, BuildContext context) {
    String? title;
    Icon? icon;
    final double iconSize = 8.w;
    if (tab == AppBottomTab.home) {
      icon = Icon(Icons.home, size: iconSize);
      title = Strings.home;
    } else if (tab == AppBottomTab.profile) {
      icon = Icon(FontAwesomeIcons.grinAlt, size: iconSize);
      title = Strings.profile;
    }
    return BottomNavigationBarItem(
      icon: icon!,
      label: title,
      //? En caso de usar la propiedad Title
      // title: Padding(
      //   padding: EdgeInsets.only(top: 3.0.dH),
      //   child: Text(
      //     title!,
      //     textAlign: TextAlign.center,
      //     style: GoogleFonts.dmSans(
      //       fontWeight: FontWeight.w400,
      //       fontSize: 15.fS,
      //     ),
      //   ),
      // ),
    );
  }
}
