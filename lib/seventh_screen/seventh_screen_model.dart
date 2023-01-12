// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'seventh_screen_model.g.dart';

class SeventhScreenModel {
  Future<void> doSome() async {
    // тут мы регистрируем адаптеры для разных боксов
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(PetAdapter());
    }

    // два бокса для хранения разных классов
    var box = await Hive.openBox<User>('textBox');
    var petBox = await Hive.openBox<Pet>('petBox');

    // создаем экземпляр для питомца
    final pet = Pet('pushok');

    // добавляем питомца в бокс
    petBox.add(pet);

    // создаем лист с питомцами
    final pets = HiveList(petBox, objects: [pet]);

    // передаем в обьект список вместе с другими данными
    final user = User('Alex', 12, pets);

    // добавляем в бокс с юзерами нашего юзера
    await box.put('user', user);

    // дальше можно получить из юзера его питомцев
    print(pet);
  }
}

// класс обьекта который мы будем добавлять
@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  // свойство в котором мы передаем нужный тип
  @HiveField(2)
  HiveList<Pet> pets;

  User(
    this.name,
    this.age,
    this.pets,
  );

  @override
  String toString() => 'Name: $name, age: $age';
}

// класс питомцев
@HiveType(typeId: 1)
class Pet extends HiveObject {
  @HiveField(0)
  String name;

  Pet(this.name);

  @override
  String toString() => 'Name: $name';
}
