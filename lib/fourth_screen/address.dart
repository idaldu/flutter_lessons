import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final String city;
  final String street;
  final String house;
  final int flat;

  Address({
    required this.city,
    required this.street,
    required this.house,
    required this.flat,
  });

  // это методы для автоматически сгенерированого кода,
  // просто вызывают нужные методы
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  // // из json в обьекты
  // factory Address.fromJson(Map<String, dynamic> json) {
  //   return Address(
  //     city: json['city'] as String,
  //     street: json['street'] as String,
  //     house: json['house'] as String,
  //     flat: json['flat'] as int,
  //   );
  // }

  // // из обьектов в json
  // // TODO: почему тут не используем factory?
  // Map<String, dynamic> toJson() {
  //   return {
  //     'city': city,
  //     'street': street,
  //     'house': house,
  //     'flat': flat,
  //   };
  // }
}
