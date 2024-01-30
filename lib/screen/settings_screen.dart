import 'package:flutter/material.dart';
import 'package:software_engineering/const/colors.dart';
import 'package:software_engineering/screen/about.dart';
import 'package:software_engineering/screen/clear_record.dart';
import 'package:software_engineering/utils/reusableText.dart';
import 'package:software_engineering/utils/terms.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Navigation
              _navigation(context),
            ],
          ),
        )
      ),
    );
  }

  _navigation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClearRecord())
          ),
          child: reusableSubtitleText(
            "Clear Records",
            textColor
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () {},
          child: reusableSubtitleText(
              "About",
              textColor
          ),
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TermsAndCondition())
          ),
          child: reusableSubtitleText(
              "Terms and Condition",
              textColor
          ),
        ),
      ],
    );
  }
}
