import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/screen/introduction_screen.dart';
import 'database/data_manager.dart';

DataManager dataManager = DataManager();

void main() async {
  Animate.restartOnHotReload = true;

  WidgetsFlutterBinding.ensureInitialized();

  // initialize hive
  await Hive.initFlutter();

  // open hive database
  //await Hive.openBox('test_database');

  //await dataManager.initializeData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataManager(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const IntroductionScreen(),
      ),
    );
  }
}
