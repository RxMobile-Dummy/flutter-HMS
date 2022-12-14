import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/style.dart';

class Button extends StatelessWidget {
  String title;
  var onPress;
  double verticalMargin;
  double horizontalMargin;

  Button(this.title,
      {this.onPress, this.horizontalMargin = 16, this.verticalMargin = 32});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin, vertical: verticalMargin),
      child: RaisedButton(
        color: CustomColors.colorDarkBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: EdgeInsets.all(12),
        onPressed: onPress,
        child: Text(
          title,
          style: CustomTextStyle.styleBold.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}