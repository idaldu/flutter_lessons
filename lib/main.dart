import 'package:flutter/material.dart';
import 'package:lesson_47/home_screen/home_screen.dart';
import 'package:lesson_47/pages_screen/pages_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const HomeScreen(),
        '/pages': (context) => const PagesScreen(),
      },
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) => MaterialPageRoute<void>(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
