import 'package:flutter/material.dart';
import 'package:skivvy_app/theme.dart';
import 'package:skivvy_app/widgets/welcome_body.dart';
import 'package:skivvy_app/store/size_config.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcomes';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        decoration: BoxDecoration(gradient: skivvyBaseGradientColor),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: WelcomeBody(),
        ));
  }
}
