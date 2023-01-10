// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lesson_47/fifth_screen/domain/api_clients/api_client.dart';

import 'package:lesson_47/fifth_screen/domain/entity/post.dart';

class FifthScreenModel extends ChangeNotifier {
  final apiClient = ApiClient();
  var _posts = <Post>[];

  // чтобы его не мог никто изменить используем геттер,
  // не смогут менять т.к он приватный
  List<Post> get posts => _posts;

  // методы
  Future<void> reloadPosts() async {
    final posts = await apiClient.getPosts();
    _posts += posts;
    notifyListeners();
  }

  Future<void> createPost() async {
    final post = await apiClient.createPost(
      title: 'text-title',
      body: 'test-body',
    );
  }
}

class FifthScreenModelProvider extends InheritedNotifier {
  final FifthScreenModel model;
  const FifthScreenModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(
          notifier: model,
          child: child,
        );

  // подписывается на изменения
  static FifthScreenModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FifthScreenModelProvider>();
  }

  // получаем инхерит, но не подписывается
  static FifthScreenModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<FifthScreenModelProvider>()
        ?.widget;
    return widget is FifthScreenModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(FifthScreenModelProvider oldWidget) {
    return true;
  }
}
