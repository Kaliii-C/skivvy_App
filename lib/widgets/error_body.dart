import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:skivvy_app/store/size_config.dart';

class ErrorBody extends StatelessWidget {
  const ErrorBody({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({String error}) {
    return Row(
      children: [
        Icon(
          MdiIcons.alertCircle,
          size: (14),
        ),
        SizedBox(
          width: getPropScreenWidth(10),
        ),
        Text(error),
      ],
    );
  }
}
