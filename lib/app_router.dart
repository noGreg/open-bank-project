// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'features/auth/screens/forgot_password_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/sign_up_screen.dart';
import 'features/home/ui/screens/home_screen.dart';
import 'features/home/ui/screens/profile_screen.dart';

class AppRouter {
  ///
  /// Given a [route name]...
  ///Build a route base on the current Platform [IOS] and [Android]
  ///
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildPage(const LoginScreen());
      case LoginScreen.routeName:
        return _buildPage(const LoginScreen());
      case SignUpScreen.routeName:
        return _buildPage(const SignUpScreen());
      case ForgotPasswordScreen.routeName:
        return _buildPage(const ForgotPasswordScreen());
      case HomeScreen.routeName:
        return _buildTabPage(const HomeScreen());

      case ProfileScreen.routeName:
        return _buildTabPage(const ProfileScreen());

      default:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

//Build a route base on the current Platform [IOS] and [Android]
  static Route<dynamic> _buildPage(
    Widget page, {
    String? routeName,
    Object? arguments,
  }) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: (_) => page,
        settings: RouteSettings(name: routeName, arguments: arguments),
      );
    } else {
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        settings: RouteSettings(name: routeName, arguments: arguments),
      );
    }
  }

// build a specific route for the screens that the tab page contains
  // ignore: unused_element
  static Route<dynamic> _buildTabPage(
    Widget page, {
    String? routeName,
    Object? arguments,
  }) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      settings: RouteSettings(name: routeName, arguments: arguments),
    );
  }
}
