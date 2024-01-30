import 'package:software_engineering/models/question.dart';

class Quiz {
  String name;
  bool isCompleted;
  List<Question> questions;

  Quiz({
    required this.name,
    this.isCompleted = false,
    required this.questions,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isCompleted': isCompleted,
      'question': questions.map((q) => q.toJson()).toList(),
    };
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    try {
      return Quiz(
        name: json['name'] ?? '',
        isCompleted: json['isCompleted'] ?? false,
        questions: (json['question'] as List<dynamic>?)?.map((q) => Question.fromJson(q as Map<String, dynamic>)).toList() ?? [],
      );
    } catch (e) {
      print('Error parsing JSON data: $e');
      throw FormatException('Invalid question format');
    }
  }




}
