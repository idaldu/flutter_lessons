import 'package:json_annotation/json_annotation.dart';
import 'package:lesson_47/fourth_screen/address.dart';

part 'human.g.dart';

@JsonSerializable()
class Human {
  final String name;
  final String surname;
  int age;
  List<Address> addresses;

  Human({
    required this.name,
    required this.surname,
    required this.age,
    required this.addresses,
  });

  // это методы для автоматически сгенерированого кода,
  // просто вызывают нужные методы
  factory Human.fromJson(Map<String, dynamic> json) => _$HumanFromJson(json);

  Map<String, dynamic> toJson() => _$HumanToJson(this);

  // // из json в обьекты
  // factory Human.fromJson(Map<String, dynamic> json) {
  //   return Human(
  //       name: json['name'] as String,
  //       surname: json['surname'] as String,
  //       age: json['age'] as int,
  //       addresses: (json['addresses'] as List<dynamic>)
  //           .map((dynamic e) => Address.fromJson(e as Map<String, dynamic>))
  //           .toList());
  // }

  // // из обьектов в json
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'surname': surname,
  //     'age': age,
  //     'addreses': addresses.map((e) => e.toJson()).toList(),
  //   };
  // }
}
