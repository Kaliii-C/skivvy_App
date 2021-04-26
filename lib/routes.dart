import 'package:flutter/material.dart';
import 'package:skivvy_app/screens/Login_screen.dart';
import 'package:skivvy_app/screens/add_event_screen.dart';
import 'package:skivvy_app/screens/dashboard_screen.dart';
import 'package:skivvy_app/screens/calendar_screen.dart';
import 'package:skivvy_app/screens/board_screen.dart';
import 'package:skivvy_app/screens/lists_screen.dart';
import 'package:skivvy_app/screens/mates_screen.dart';

final Map<String, WidgetBuilder> routes = {
  DashboardScreen.routeName: (ctx) => DashboardScreen(),
  CalendarScreen.routeName: (ctx) => CalendarScreen(),
  ListsScreen.routeName: (ctx) => ListsScreen(),
  MatesScreen.routeName: (ctx) => MatesScreen(),
  BoardScreen.routeName: (ctx) => BoardScreen(),
  LoginScreen.routeName: (ctx) => LoginScreen(),
  AddEventScreen.routeName: (cts) => AddEventScreen()
};
