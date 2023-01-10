import 'dart:convert';
import 'dart:io';

import 'package:lesson_47/fifth_screen/domain/entity/post.dart';

class ApiClient {
  // создаем клиент
  final client = HttpClient();

  Future<List<Post>> getPosts() async {
    // тут можем заменить на Uri.parse и достать все из строки
    // но так лучше по идее, так как мы в константах передаем все что не меняется.
    const String scheme = 'http';
    const String host = 'jsonplaceholder.typicode.com';
    final url = Uri(scheme: scheme, host: host, path: 'posts');

    // тут мы ждем когда соберется запрос и отправится
    final request = await client.getUrl(url);

    // тут мы ждем когда ответ придет с сервера
    final response = await request.close();

    // склеиваем из поступающих данных лист строк
    final jsonStrings = await response.transform(utf8.decoder).toList();

    // собираем из листа одну строку
    final jsonString = jsonStrings.join();

    // создаем из строки json
    final json = jsonDecode(jsonString) as List<dynamic>;

    // получаем массив постов с помощью модели и ее метода
    final posts = json
        .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();

    // возвращаем эти посты
    return posts;
  }

  // можно создать себе helper с помощью которого получим
  // универсальную функцию получения json, a затем подставить ее куда нужно
  // Future<List<dynamic>> get() async {
  //   final url = Uri.parse('http://jsonplaceholder.typicode.com/posts');
  //   final request = await client.getUrl(url);
  //   final response = await request.close();

  //   final jsonStrings = await response.transform(utf8.decoder).toList();
  //   final jsonString = jsonStrings.join();
  //   final json = jsonDecode(jsonString) as List<dynamic>;
  //   return json;
  // }

  Future<Post?> createPost(
      {required String title, required String body}) async {
    // распарсили uri автоматически
    final url = Uri.parse('http://jsonplaceholder.typicode.com/posts');
    final request = await client.postUrl(url);

    // передали хедеры которые были в доке
    request.headers.set('Content-type', 'application/json; charset=UTF-8');

    // передали параметры которые были в доке
    final parameters = <String, dynamic>{
      'title': title,
      'body': body,
      'userId': 109
    };
    request.write(jsonEncode(parameters));
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final post = Post.fromJson(json);
    return post;
  }
}
