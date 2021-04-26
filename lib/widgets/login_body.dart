import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skivvy_app/store/size_config.dart';
import 'package:skivvy_app/theme.dart';
import 'package:skivvy_app/widgets/auth_form.dart';

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getPropScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                'Welcome',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: skivvyBaseColor,
                        fontSize: getPropScreenWidth(26.0),
                        fontWeight: FontWeight.w500)),
              ),
              Text(
                  'Sign in with your email and password or Sign up for new account',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins()),
              AuthForm(),
            ]),
          ),
        ),
      ),
    );
  }
}
