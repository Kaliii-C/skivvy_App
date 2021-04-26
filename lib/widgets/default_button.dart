import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:skivvy_app/store/size_config.dart';
import 'package:skivvy_app/theme.dart';

class DefaultBtn extends StatelessWidget {
  const DefaultBtn({
    Key key,
    this.text,
    this.click,
  }) : super(key: key);
  final String text;
  final Function click;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getPropScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: click,
        child: Text(
          text,
          style: GoogleFonts.poppins(
              color: textColor, fontSize: getPropScreenWidth(16)),
        ),
        color: skivvySecondaryColor,
      ),
    );
  }
}
