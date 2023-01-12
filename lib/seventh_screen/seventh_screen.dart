import 'package:flutter/material.dart';
import 'package:lesson_47/seventh_screen/seventh_screen_model.dart';

class SeventhScreen extends StatefulWidget {
  const SeventhScreen({Key? key}) : super(key: key);

  @override
  _SeventhScreenState createState() => _SeventhScreenState();
}

class _SeventhScreenState extends State<SeventhScreen> {
  final model = SeventhScreenModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: model.doSome,
            child: const Text('Жми меня'),
          ),
        ),
      ),
    );
  }
}
