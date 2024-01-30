import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import '../models/quiz.dart';
import '../models/quiz_adapter.dart';
import '../models/result.dart';
import '../models/result_adapter.dart';

class HiveDatabase {
  late Box _box;

  Future<void> init() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Register the QuizAdapter
    Hive.registerAdapter(QuizAdapter());

    // Register the adapter
    Hive.registerAdapter(ResultAdapter());

    // Open the existing 'test_database' box or create a new one if it doesn't exist
    _box = await Hive.openBox('test_database');
  }

  bool previousDataExists() {
    if(_box.isNotEmpty) {
      print("TRUE HAS DATA");
      return true;
    } else {
      print("FALSE EMPTY");
      return false;
    }
  }

  List<Quiz> readQuizListFromDatabase() {
    final dynamic data = _box.get('quizList');

    if (data == null) {
      return [];
    }

    List<Quiz> quizList = [];
    if (data is List) {
      for (var entry in data) {
        if (entry is Map<dynamic, dynamic>) {
          final Map<String, dynamic> typedEntry = {};
          entry.forEach((key, value) {
            if (key is String) {
              typedEntry[key] = value;
            }
          });
          try {
            quizList.add(Quiz.fromJson(typedEntry));
          } catch (e) {
            print("Error parsing JSON data: $e");
            print("Entry type: ${entry.runtimeType}");
            print("Entry content: $entry");
          }
        } else {
          print("Entry is not a Map<dynamic, dynamic>: $entry");
        }
      }
    }

    return quizList;
  }

  List<Map<String, dynamic>> readQuizResultFromDatabase() {
    final dynamic data = _box.get('quizResult', defaultValue: []);

    List<Map<String, dynamic>> quizResult = [];
    if (data is List<Map<dynamic, dynamic>>) {
      // Convert keys to strings
      quizResult = data.map((entry) {
        return entry.map((key, value) => MapEntry(key.toString(), value));
      }).toList();
    }

    return quizResult;
  }

  void saveToDatabase(List<Quiz> quizList, List<Result> quizResult) {
    print(quizList);
    try {
      _box.put('quizList', quizList.map((quiz) => quiz.toJson()).toList());
      _box.put('quizResult', quizResult.map((result) => result.toJson()).toList());
      print(quizList);


    } catch (e) {
      print('Error saving data: $e');
    }
  }
}
