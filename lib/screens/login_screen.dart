import 'package:flutter/material.dart';

import 'package:skivvy_app/theme.dart';
import 'package:skivvy_app/widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: LoginBody(),
    );
  }
}
