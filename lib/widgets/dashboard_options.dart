import 'package:flutter/material.dart';

import '../screens/calendar_screen.dart';
import '../screens/board_screen.dart';
import '../screens/lists_screen.dart';
import '../screens/mates_screen.dart';

class DashboardOptions extends StatelessWidget {
  final String id;
  final String title;
  final Image icon;

  DashboardOptions(this.id, this.title, this.icon);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
            onTap: () {
              switch (title) {
                case 'Calendar':
                  Navigator.of(context)
                      .pushNamed(CalendarScreen.routeName, arguments: id);
                  break;
                case 'Lists':
                  Navigator.of(context)
                      .pushNamed(ListsScreen.routeName, arguments: id);
                  break;
                case 'My Mates':
                  Navigator.of(context)
                      .pushNamed(MatesScreen.routeName, arguments: id);
                  break;
                case 'My Board':
                  Navigator.of(context)
                      .pushNamed(BoardScreen.routeName, arguments: id);
                  break;
                default:
              }
            },
            child: GridTile(
              footer: GridTileBar(
                  backgroundColor: Color.fromRGBO(249, 168, 38, 0.5),
                  title: Text(
                    title,
                    textAlign: TextAlign.center,
                  )),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).accentColor),
                ),
                child: icon,
              ),
            )));
  }
}
