import 'package:flutter/material.dart';
import 'package:skivvy_app/store/size_config.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:skivvy_app/theme.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          'Skivvy',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            fontSize: getPropScreenWidth(40.0),
            color: skivvySecondaryColor,
            fontWeight: FontWeight.bold,
          )),
        ),
        Text(
          text,
          style: GoogleFonts.poppins(),
          textAlign: TextAlign.center,
        ),
        Spacer(
          flex: 1,
        ),
        Image.asset(
          image,
          width: getPropScreenWidth(245),
          height: getPropScreenHeight(275),
        ),
      ],
    );
  }
}
