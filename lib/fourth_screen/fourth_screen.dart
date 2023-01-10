import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lesson_47/fourth_screen/fourth_screen_data.dart';
import 'package:lesson_47/fourth_screen/human.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: JsonExampleProvider(
          coder: JsonExampleCoder(),
          child: const ButtonWidget(),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () =>
                  JsonExampleProvider.read(context)?.coder.decode(),
              child: const Text('Декодировать')),
          ElevatedButton(
              onPressed: () =>
                  JsonExampleProvider.read(context)?.coder.encode(),
              child: const Text('Кодировать')),
        ],
      ),
    );
  }
}

class JsonExampleProvider extends InheritedWidget {
  final JsonExampleCoder coder;
  const JsonExampleProvider({
    super.key,
    required Widget child,
    required this.coder,
  }) : super(child: child);

  static JsonExampleProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<JsonExampleProvider>();
  }

  static JsonExampleProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<JsonExampleProvider>()
        ?.widget;
    return widget is JsonExampleProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(JsonExampleProvider oldWidget) {
    return true;
  }
}

class JsonExampleCoder {
  encode() {
    try {
      final objects = humans.map((e) => e.toJson()).toList();
      final jsonString = jsonEncode(objects);
      print(jsonString);
    } catch (error) {
      print(error);
    }
  }

  decode() {
    try {
      final json = jsonDecode(jsonString) as List<dynamic>;
      final humans =
          json.map((e) => Human.fromJson(e as Map<String, dynamic>)).toList();
      print(humans);
    } catch (error) {
      print(error);
    }
  }
}
