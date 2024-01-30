import 'package:hive/hive.dart';
import 'package:software_engineering/models/quiz.dart';

class QuizAdapter extends TypeAdapter<Quiz> {
  @override
  final int typeId = 0; // Unique ID for this TypeAdapter

  @override
  Quiz read(BinaryReader reader) {
    // Read the dynamic map from Hive
    final dynamic mapData = reader.read();

    // Convert the dynamic map to Map<String, dynamic>
    final Map<String, dynamic> jsonMap = Map<String, dynamic>.from(mapData);

    // Pass the Map<String, dynamic> to the fromJson constructor of Quiz
    return Quiz.fromJson(jsonMap);
  }

  @override
  void write(BinaryWriter writer, Quiz obj) {
    // Write the JSON representation of Quiz to Hive
    writer.write(obj.toJson());
  }
}
