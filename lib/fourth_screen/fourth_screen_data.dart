import 'package:lesson_47/fourth_screen/address.dart';
import 'package:lesson_47/fourth_screen/human.dart';

final humans = [
  Human(name: 'John', surname: 'Doe', age: 30, addresses: [
    Address(city: 'New York', street: 'Fifth Avenue', house: '1A', flat: 1),
    Address(city: 'New York', street: 'Sixth Avenue', house: '2B', flat: 2),
    Address(city: 'New York', street: 'Seventh Avenue', house: '3C', flat: 3),
  ]),
  Human(name: 'Jane', surname: 'Doe', age: 28, addresses: [
    Address(city: 'Boston', street: 'Main Street', house: '4D', flat: 4),
    Address(city: 'Boston', street: 'Second Street', house: '5E', flat: 5),
    Address(city: 'Boston', street: 'Third Street', house: '6F', flat: 6),
  ])
];

const jsonString = '''
[
  {
    "name": "John",
    "surname": "Doe",
    "age": 30,
    "addresses": [
    {
      "city": "New York",
      "street": "Fifth Avenue",
      "house": "1A",
      "flat": 1
    },
    {
      "city": "New York",
      "street": "Sixth Avenue",
      "house": "2B",
      "flat": 2
    },
    {
      "city": "New York",
      "street": "Seventh Avenue",
      "house": "3C",
      "flat": 3
    }]
  },
  {
    "name": "Jane",
    "surname": "Doe",
    "age": 28,
    "addresses": [
    {
      "city": "Boston",
      "street": "Main Street",
      "house": "4D",
      "flat": 4
    },
    {
      "city": "Boston",
      "street": "Second Street",
      "house": "5E",
      "flat": 5
    },
    {
      "city": "Boston",
      "street": "Third Street",
      "house": "6F",
      "flat": 6
    }]
  }
]
''';
