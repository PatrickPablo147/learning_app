import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../database/data_manager.dart';
import '../utils/reusableText.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({Key? key}) : super(key: key);

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  TextEditingController quizNameController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  List<TextEditingController> optionControllers = [];
  int? selectedOptions;

  @override
  void initState() {
    super.initState();
    // Initialize optionControllers list with empty controllers
    for (int i = 0; i < 4; i++) {
      optionControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    // Dispose all optionControllers when the state is disposed
    for (var controller in optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, value, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),

                  const SizedBox(height: 20),
                  TextField(
                    controller: quizNameController,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Quiz Name',
                      hintStyle: GoogleFonts.inter(
                        color: grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return _questionBuilder(index);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _questionBuilder(int id) {
    return Column(
      children: [
        TextField(
          controller: questionController,
          textAlign: TextAlign.start,
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 16,
            letterSpacing: -0.5,
          ),
          decoration: InputDecoration(
            labelText: 'Question ${id + 1}',
            labelStyle: GoogleFonts.inter(
              color: Colors.black
            ),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
            ),
            hintText: 'Question ${id + 1}',
            hintStyle: GoogleFonts.inter(
              color: grey,
              fontSize: 16,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: optionControllers[index], // Assigning specific controller to each TextField
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                        letterSpacing: -0.5,
                      ),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        labelText: 'Option ${index + 1}',
                        labelStyle: GoogleFonts.inter(
                            color: Colors.black
                        ),
                        hintText: 'Option ${index + 1}',
                        hintStyle: GoogleFonts.inter(
                          color: grey,
                          fontSize: 16,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Radio<int>(
                  value: index, // Set the value of this RadioListTile to its index
                  groupValue: selectedOptions, // Use the selected option index for this group
                  onChanged: (value) {
                    setState(() {
                      // Only update if the newly selected value is different from the current value
                      selectedOptions = value!;
                    });
                  },
                )
              ],
            );
          },
        )
      ],
    );
  }

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        reusableTitleText('Add New Quiz', textColor),

        // Save Button
        MaterialButton(
            minWidth: 132,
            height: 46,
            elevation: 0,
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: () {},
            child: reusableSubtitleText('Save', Colors.white)
        )
      ],
    );
  }
}
