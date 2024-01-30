import 'package:software_engineering/models/question.dart';

class Quiz {
  final String name;
  bool isCompleted;
  final List<Question> question;

  Quiz({
    required this.name,
    this.isCompleted = false,
    required this.question,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isCompleted': isCompleted,
      'question': question.map((q) => q.toJson()).toList(),
    };
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    try {
      return Quiz(
        name: json['name'] ?? '',
        isCompleted: json['isCompleted'] ?? false,
        question: (json['question'] as List<dynamic>?)?.map((q) => Question.fromJson(q as Map<String, dynamic>)).toList() ?? [],
      );
    } catch (e) {
      print('Error parsing JSON data: $e');
      throw FormatException('Invalid question format');
    }
  }




}
