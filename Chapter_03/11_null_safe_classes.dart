void main() {
  var bruce = Person('Bruce', 'Wayne', age: 42);
  if ((bruce.age ?? 0) < 18) {
    print('Minor');
  }
  Person? person;
  print(person?.name);
}

class Person {
  late String name;
  late String surname;
  int? age;

  Person(this.name, this.surname, {this.age});
  Person.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    surname = map['surname'];
  }
}
