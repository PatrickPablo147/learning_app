import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:software_engineering/controller/bottom_nav_bar.dart';
import 'package:software_engineering/screen/introduction_screen.dart';
import 'database/data_manager.dart';

DataManager dataManager = DataManager();
int? initScreen;

void main() async {
  Animate.restartOnHotReload = true;

  WidgetsFlutterBinding.ensureInitialized();

  // initialize hive
  await Hive.initFlutter();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');

  await preferences.setInt('initScreen', 1);

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
        initialRoute: initScreen == 0 || initScreen == null ? 'onboard' : 'home',
        routes: {
          'home': (context) => const MyBottomNavBar(),
          'onboard': (context) => const IntroductionScreen(),
        },
      ),
    );
  }
}
