import 'package:flutter/material.dart';
import 'package:software_engineering/utils/reusableText.dart';
import '../const/colors.dart';

class ReusableButton extends StatelessWidget {
  final String message;
  final Function onTap;

  const ReusableButton({Key? key, required this.message, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: 132,
        height: 46,
        elevation: 0,
        color: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Set your desired border radius
        ),
        onPressed: onTap(),
        child: reusableSubtitleText(message, Colors.white)
    );
  }
}
