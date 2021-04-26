import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skivvy_app/models/plan.dart';
import 'package:skivvy_app/providers/auth.dart';
import 'package:skivvy_app/providers/lists.dart';
import 'package:skivvy_app/providers/plans.dart';
import 'package:skivvy_app/providers/user.dart';
import 'package:skivvy_app/screens/welcome_screen.dart';
import 'package:skivvy_app/theme.dart';
import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Plans>(
            update: (ctx, auth, previousPlans) => Plans(auth.token, auth.userId,
                previousPlans == null ? [] : previousPlans.events),
          ),
          ChangeNotifierProxyProvider<Auth, ListData>(
            update: (ctx, auth, previousLists) => ListData(
              auth.userId,
            ),
          ),
          ChangeNotifierProvider.value(
            value: User(),
          ),
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'Skivvy',
                  theme: theme(),
                  home: WelcomeScreen(),
                  routes: routes,
                )));
  }
}
