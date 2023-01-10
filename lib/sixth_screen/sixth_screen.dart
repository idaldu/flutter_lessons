import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class SixthScreen extends StatefulWidget {
  const SixthScreen({Key? key}) : super(key: key);

  @override
  _SixthScreenState createState() => _SixthScreenState();
}

class _SixthScreenState extends State<SixthScreen> {
  final _model = FifthScreenModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SixthScreenModelProvider(
          model: _model,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Center(
                child: _ReadFileButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReadFileButton extends StatelessWidget {
  const _ReadFileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: SixthScreenModelProvider.read(context)?.model.readFile,
      child: const Text('Прочитать файл'),
    );
  }
}

class FifthScreenModel extends ChangeNotifier {
  void readFile() async {
    // подключили папку с документами
    final directory = await pathProvider.getApplicationDocumentsDirectory();

    // данный метод дает возможность открыть файл который мы укажем
    // при этом расширение файла указывать не обязательно
    final filePath = '${directory.path}/file.txt';

    // данный обьект предоставляет методы для работы с реальным файлом
    final file = File(filePath);

    // запись данных в файл
    await file.writeAsString('Привет мир!');

    // возвращает cуществет ли файл
    final isExist = await file.exists();
    print(isExist);

    // читаем строку из файла и выводим ее в консоль, только если файл существует,
    // а если его нет, то создаем его
    if (!isExist) {
      file.create();
    }
    final string = await file.readAsString();
    print(string);

    // получаем статистику по файлу, получаем флаг файла, какие есть доступы
    final result = await file.stat();
    print(result.modeString());
  }
}

// внедряет модель в дерево
class SixthScreenModelProvider extends InheritedNotifier {
  final FifthScreenModel model;
  const SixthScreenModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(
          notifier: model,
          child: child,
        );

  // подписывается на изменения
  static SixthScreenModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SixthScreenModelProvider>();
  }

  // получаем инхерит, но не подписывается
  static SixthScreenModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<SixthScreenModelProvider>()
        ?.widget;
    return widget is SixthScreenModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(SixthScreenModelProvider oldWidget) {
    return true;
  }
}
