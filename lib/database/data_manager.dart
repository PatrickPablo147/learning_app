import 'package:flutter/cupertino.dart';
import 'package:software_engineering/models/result.dart';
import '../models/option.dart';
import '../models/question.dart';
import '../models/quiz.dart';
import '../models/topics.dart';
import 'hive_database.dart';

class DataManager extends ChangeNotifier {

  final db = HiveDatabase();

  DataManager() {
    initializeData();
  }

  /* Summary:
  * A 2D Array that Generate a List of Topic eg. [1, 2, 3,], [4, 5, 6]
  * List<Topic> a class that require [Chapter num, Title, Image, isCompleted = false];
  * */

  List<List<Topic>> softwareEngineering = [
    //Software Engineering 1
    [
      Topic(topicValue: 1, topicTitle: "Introduction", topicImage: "lib/assets/engineer.png"),
      Topic(topicValue: 2, topicTitle: "Software Development Life Cycle", topicImage: "lib/assets/cycle.png"),
      Topic(topicValue: 3, topicTitle: "Software Requirements", topicImage: "lib/assets/requirement.png"),
      Topic(topicValue: 4, topicTitle: "Software Design", topicImage: "lib/assets/design.png"),
    ],
    //Software Engineering 2
    [
      Topic(topicValue: 1, topicTitle: "Software Coding", topicImage: "lib/assets/coding.png"),
      Topic(topicValue: 2, topicTitle: "Flow Graphs", topicImage: "lib/assets/flow-chart.png"),
    ]
  ];

  // Get the List of Topic then return it in List
  List<List<Topic>> getSoftwareEngineering() {
    return softwareEngineering;
  }

  List<Result> quizResult = [];

  List<Result> getQuizResult() {
    return quizResult;
  }

  void addResult(String quizName, int score) {
    quizResult.add(
      Result(quizName: quizName, score: score),
    );

    _saveData();
    notifyListeners();
  }

  void clearResult() {
    quizResult.clear();
    _saveData();
    notifyListeners();
  }

  List<Quiz> quizList = [
    Quiz(
        name: 'Chapter 1: What is software engineering?',
        isCompleted: true,
        question: [
          Question(
              text: "It is a collection of codes, documents, and triggers that does a specific job and fills a specific requirement",
              options: [
                const Option(text: 'Software', isCorrect: true),
                const Option(text: 'Engineering', isCorrect: false),
                const Option(text: 'Software engineering', isCorrect: false),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "It is the development of products using best practices, principles, and methods",
              options: [
                const Option(text: 'Software', isCorrect: false),
                const Option(text: 'Engineering', isCorrect: true),
                const Option(text: 'Software engineering', isCorrect: false),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "is a detailed study of engineering to the design, development and maintenance of software",
              options: [
                const Option(text: 'Software', isCorrect: false),
                const Option(text: 'Engineering', isCorrect: false),
                const Option(text: 'Software engineering', isCorrect: true),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "Manages and control the internal operation of a computer system.",
              options: [
                const Option(text: 'Software', isCorrect: false),
                const Option(text: 'System software', isCorrect: true),
                const Option(text: 'Software engineering', isCorrect: false),
                const Option(text: 'Engineering', isCorrect: false),
              ]
          ),
          Question(
              text: "observe, analyzes and controls real world event as the occur",
              options: [
                const Option(text: 'System software', isCorrect: false),
                const Option(text: 'Engineering and scientific software', isCorrect: false),
                const Option(text: 'Business engineering', isCorrect: false),
                const Option(text: 'Real-time software', isCorrect: true),
              ]
          ),
        ],
    ),
    Quiz(
        name: 'Chapter 2: Software development and life cycle',
        question: [
          Question(
              text: "What is SDLC means",
              options: [
                const Option(text: 'Software Development Life Cycle', isCorrect: true),
                const Option(text: 'Software Development Light Cycling', isCorrect: false),
                const Option(text: 'Soft Day Life Cycling', isCorrect: false),
                const Option(text: 'Sight Developing Light Cycle', isCorrect: false),
              ]
          ),
          Question(
              text: "Project leaders evaluate the terms of the project",
              options: [
                const Option(text: 'Planning', isCorrect: true),
                const Option(text: 'Define Requirements', isCorrect: false),
                const Option(text: 'Software Design', isCorrect: false),
                const Option(text: 'Software Engineering', isCorrect: false),
              ]
          ),
          Question(
              text: "Determine what the application is supposed to do and it's requirements",
              options: [
                const Option(text: 'Planning', isCorrect: false),
                const Option(text: 'Define Requirements', isCorrect: true),
                const Option(text: 'Software Design', isCorrect: false),
                const Option(text: 'Software Engineering', isCorrect: false),
              ]
          ),
          Question(
              text: "Consist of standardized patterns used for both architecture and software development",
              options: [
                const Option(text: 'Software', isCorrect: false),
                const Option(text: 'Engineering', isCorrect: false),
                const Option(text: 'Software design', isCorrect: true),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "Defines the way customers interact with the software",
              options: [
                const Option(text: 'Architecture', isCorrect: false),
                const Option(text: 'User Interface', isCorrect: true),
                const Option(text: 'Platforms', isCorrect: false),
                const Option(text: 'Programming', isCorrect: false),
              ]
          ),
        ]
    ),
    Quiz(
        name: 'Chapter 3: Software requirements',
        question: [
          Question(
              text: "IEEE stands for",
              options: [
                const Option(text: 'Institute of Electrical and Electronics Engineers', isCorrect: true),
                const Option(text: 'Institute of Electric and Economic Engineers', isCorrect: false),
                const Option(text: 'Inspired Eccentric Ecosystem Environment', isCorrect: false),
                const Option(text: 'Institution of Electric and Electronics Engineering', isCorrect: false),
              ]
          ),
          Question(
              text: "Defined using natural language, tables and diagrams as these can be understood by all users",
              options: [
                const Option(text: 'User requirements', isCorrect: false),
                const Option(text: 'Engineering', isCorrect: true),
                const Option(text: 'System Requirements', isCorrect: false),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "Detailed description of what the system should do including the software system's functions, services, and operational constraints",
              options: [
                const Option(text: 'Functional requirements', isCorrect: false),
                const Option(text: 'Software Engineering', isCorrect: false),
                const Option(text: 'Software Requirements', isCorrect: true),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "How the system should react to particular inputs and how the system should behave in particular situations",
              options: [
                const Option(text: 'Functional requirements', isCorrect: true),
                const Option(text: 'Software Engineering', isCorrect: false),
                const Option(text: 'Software Requirements', isCorrect: false),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "Define system properties and constraints e.g. reliability, response time and storage requirements",
              options: [
                const Option(text: 'Functional requirements', isCorrect: false),
                const Option(text: 'Software Engineering', isCorrect: false),
                const Option(text: 'Non-Functional Requirements', isCorrect: true),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
        ]
    ),
    Quiz(
        name: 'Chapter 4: Software process and life cycle',
        question: [
          Question(
              text: "It refers to a system for hiding irrelevant information",
              options: [
                const Option(text: 'Software', isCorrect: false),
                const Option(text: 'Process', isCorrect: true),
                const Option(text: 'Entity', isCorrect: false),
                const Option(text: 'Abstraction', isCorrect: false),
              ]
          ),
          Question(
              text: "It refers to a model or view of an item",
              options: [
                const Option(text: 'Software', isCorrect: false),
                const Option(text: 'Process', isCorrect: false),
                const Option(text: 'Entity', isCorrect: true),
                const Option(text: 'Abstraction', isCorrect: false),
              ]
          ),
          Question(
              text: "This involves the use of parameterized subprograms referred to as ‘groups'",
              options: [
                const Option(text: 'Functional Abstraction', isCorrect: true),
                const Option(text: 'Data Abstraction', isCorrect: false),
                const Option(text: 'Control Abstraction', isCorrect: false),
                const Option(text: 'System Abstraction', isCorrect: false),
              ]
          ),
          Question(
              text: "This involves specifying data that describes a data object",
              options: [
                const Option(text: 'Functional Abstraction', isCorrect: false),
                const Option(text: 'Data Abstraction', isCorrect: true),
                const Option(text: 'Control Abstraction', isCorrect: false),
                const Option(text: 'Non-Functional Abstraction', isCorrect: false),
              ]
          ),
          Question(
              text: "This states the desired effect, without stating the exact mechanism of control",
              options: [
                const Option(text: 'Functional Abstraction', isCorrect: false),
                const Option(text: 'Data Abstraction', isCorrect: false),
                const Option(text: 'Control Abstraction', isCorrect: true),
                const Option(text: 'System Abstraction', isCorrect: false),
              ]
          ),
        ]
    ),
    Quiz(
        name: 'Chapter 1: What is software2 engineering?',
        question: [
          Question(
              text: "It is a collection of codes, documents, and triggers that does a specific job and fills a specific requirement",
              options: [
                const Option(text: 'Software', isCorrect: true),
                const Option(text: 'Engineering', isCorrect: false),
                const Option(text: 'Software engineering', isCorrect: false),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "It is the development of products using best practices, principles, and methods",
              options: [
                const Option(text: 'Software', isCorrect: false),
                const Option(text: 'Engineering', isCorrect: true),
                const Option(text: 'Software engineering', isCorrect: false),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "is a detailed study of engineering to the design, development and maintenance of software",
              options: [
                const Option(text: 'Software', isCorrect: false),
                const Option(text: 'Engineering', isCorrect: false),
                const Option(text: 'Software engineering', isCorrect: true),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
        ]
    ),
    Quiz(
        name: 'Chapter 2: Software2 process and life cycle',
        question: [
          Question(
              text: "It is a collection of codes, documents, and triggers that does a specific job and fills a specific requirement",
              options: [
                const Option(text: 'Software', isCorrect: true),
                const Option(text: 'Engineering', isCorrect: false),
                const Option(text: 'Software engineering', isCorrect: false),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "It is the development of products using best practices, principles, and methods",
              options: [
                const Option(text: 'Software', isCorrect: false),
                const Option(text: 'Engineering', isCorrect: true),
                const Option(text: 'Software engineering', isCorrect: false),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "is a detailed study of engineering to the design, development and maintenance of software",
              options: [
                const Option(text: 'Software', isCorrect: false),
                const Option(text: 'Engineering', isCorrect: false),
                const Option(text: 'Software engineering', isCorrect: true),
                const Option(text: 'System software', isCorrect: false),
              ]
          ),
        ]
    ),
  ];

  List<Quiz> getQuizList() {
    return quizList;
  }

  void initializeData() async {
    await db.init();
    print("RUN DATABASE SUCCESSFULLY");

    if (db.previousDataExists()) {
      print("READ");

      final data = db.readFromDatabase();

      // Retrieve quizList and quizResult from the data map
      quizList = data['quizList'];
      quizResult = data['quizResult'];

    } else {
      print("SAVE");
      _saveData(); // Save default data
    }

    print("ACCESS");
  }

  void _saveData() {
    print("SAVE");
    print(quizList);
    print(quizResult);
    db.saveToDatabase(quizList, quizResult);

  }
}