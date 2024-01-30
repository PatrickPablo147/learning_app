import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import '../models/option.dart';
import '../models/question.dart';
import '../models/quiz.dart';
import '../models/result.dart';

class HiveDatabase {
  late Box _box;

  Future<void> init() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Open the existing 'test_database' box or create a new one if it doesn't exist
    _box = await Hive.openBox('test_database');
  }

  bool previousDataExists() {
    return _box.isNotEmpty;
  }

  List<List<String>> convertQuizListToJson(List<Quiz> quizList) {
    List<List<String>> jsonQuizList = [];
    for (var quiz in quizList) {
      List<String> quizData = [
        quiz.name.toString(), // Ensure name is converted to string
        quiz.isCompleted.toString(),
      ];
      for (var question in quiz.question) {
        List<String> questionData = [
          question.text,
          question.options.map((option) => option.text).join(';'),
          question.options.map((option) => option.isCorrect.toString()).join(';'),
          question.isLocked.toString(),
          question.selectedOption == null ? 'null' : '',
        ];
        print('question data: $questionData');
        quizData.add(questionData.join('|'));
        print('quiz data: $quizData');
      }
      jsonQuizList.add(quizData);
      print('JSON QUIZLIST: $jsonQuizList');
    }

    print('Type of quizListData: ${jsonQuizList.runtimeType}');
    print('converted QuizList to Json: $jsonQuizList');
    return jsonQuizList;
  }

  List<Quiz> convertJsonToQuizList(List<List<String>> jsonQuizList) {
    List<Quiz> quizList = [];
    print(jsonQuizList);
    for (var quizData in jsonQuizList) {
      List<Question> questions = [];
      for (var questionData in quizData.skip(2)) {
        List<String> questionFields = questionData.split('|');
        List<Option> options = [];
        print('Question Fields: $questionFields');
        List<String> optionTexts = questionFields[1].split(';');
        List<String> optionCorrectness = questionFields[2].split(';');
        print('Option Texts: $optionTexts');
        print('Option Correctness: $optionCorrectness');
        for (int i = 0; i < optionTexts.length; i++) {
          if (optionTexts[i].isNotEmpty) {
            bool isCorrect = optionCorrectness[i] == 'true';
            options.add(Option(
              text: optionTexts[i],
              isCorrect: isCorrect,
            ));
          }
        }
        questions.add(Question(
          text: questionFields[0],
          options: options,
          isLocked: questionFields[3] == 'true',
          selectedOption: null,
        ));
      }
      quizList.add(Quiz(
        name: quizData[0],
        isCompleted: quizData[1] == 'true',
        question: questions,
      ));
    }
    print('converted Quiz List: $quizList');
    return quizList;
  }

  List<List<String>> convertQuizResultListToJson(List<Result> quizResultList) {
    List<List<String>> jsonQuizResultList = [];
    for (var result in quizResultList) {
      List<String> resultData = [
        result.quizName,
        result.score.toString(),
      ];
      jsonQuizResultList.add(resultData);
    }
    return jsonQuizResultList;
  }

  List<Result> convertJsonToQuizResultList(List<List<String>> jsonQuizResultList) {
    List<Result> quizResultList = [];
    for (var resultData in jsonQuizResultList) {
      // Parse the score as a double
      double score = double.parse(resultData[1]);
      // Convert it to an integer if necessary
      int scoreInt = score.toInt();
      quizResultList.add(Result(
        quizName: resultData[0],
        score: scoreInt,
      ));
    }

    return quizResultList;
  }

  Map<String, dynamic> readFromDatabase() {
    Map<String, dynamic> data = {}; // Create a map to store user data

    final dynamic quizListData = _box.get('quizList');
    final dynamic quizResultData = _box.get('quizResult');

    print('quizList data type: ${quizListData.runtimeType}');
    // Convert quiz list data
    List<Quiz> quizList = [];

    if (quizListData is List<List<String>>) {
      // If quizListData is already of type List<List<String>>, use it directly
      quizList = convertJsonToQuizList(quizListData);
    } else if (quizListData is List<dynamic>) {
      // If quizListData is of type List<dynamic>, try to cast it to List<List<String>>
      List<dynamic> dynamicList = quizListData;
      List<List<String>> convertedList =
      dynamicList.cast<List<String>>().toList();
      quizList = convertJsonToQuizList(convertedList);
    } else {
      print('Unexpected quizListData type: ${quizListData.runtimeType}');
    }

    // Convert quiz result data
    List<Result> quizResult = [];
    if (quizResultData is List<List<String>>) {
      quizResult = convertJsonToQuizResultList(quizResultData);
    }

    data['quizList'] = quizList;
    data['quizResult'] = quizResult;

    print('quiz result from db: $quizResult');
    print('quizList from db: $quizList');

    return data;
  }

  void saveToDatabase(List<Quiz> quizList, List<Result> quizResult) {
    try {
      final jsonQuizList = convertQuizListToJson(quizList);
      final jsonQuizResultList = convertQuizResultListToJson(quizResult); // Convert quiz result list to JSON
      _box.put('quizList', jsonQuizList);
      _box.put('quizResult', jsonQuizResultList);
      print('Saved Json quizList: $jsonQuizList');
      print('Saved Json quiz List type: ${jsonQuizList.runtimeType}');
      print('Data saved successfully');
    } catch (e) {
      print('Error saving data: $e');
    }
  }

}
