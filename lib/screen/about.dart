import 'package:flutter/material.dart';
import 'package:software_engineering/utils/reusableText.dart';
import '../const/colors.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(context),
                ],
              ),
            ),
          )
      ),
    );
  }

  _header(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          color: primaryColor,
          height: 46, minWidth: 50,
          padding: const EdgeInsets.only(right: 4),
          shape: const CircleBorder(),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.2),
          child: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,),
        ),
        Expanded(
          child: Center(child: reusableTitleText("About", textColor)),
        )
      ],
    );
  }
}
