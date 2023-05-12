void main() {
  collectionPlayground();
}

void collectionPlayground() {
  listPlayground();
  mapPlayground();
  setPlayground();
  collectionControlFlow();
}

void listPlayground() {
  // Creating with list literal syntax
  final List<int> numbers = [1, 2, 3, 5, 7];
  numbers.add(11);
  numbers.addAll([8, 17, 35]);
  // Assigning via subscript
  numbers[1] = 15;
  print('The second number is ${numbers[1]}');
  for (int number in numbers) {
    print(number);
  }
}

void mapPlayground() {
// Map Literal syntax
  final Map<String, int> ages = {
    'Clark': 26,
    'Peter': 35,
    'Bruce': 44,
  };
  // Subscript syntax uses the key type.
// A String in this case
  ages['Steve'] = 48;
  final ageOfPeter = ages['Peter'];
  print('Peter is $ageOfPeter years old.');
  ages.remove('Peter');
  ages.forEach((String name, int age) {
    print('$name is $age years old');
  });
}

void setPlayground() {
// Set literal, similar to Map, but no keys
  final Set<String> ministers = {
    'Justin',
    'Stephen',
    'Paul',
    'Jean',
    'Kim',
    'Brian'
  };
  ministers.addAll({
    'John',
    'Pierre',
    'Joe',
    'Pierre'
  }); //Pierre is a duplicate, which is not allowed in a set.
  final isJustinAMinister = ministers.contains('Justin');
  print(isJustinAMinister);
// 'Pierre' will only be printed once
// Duplicates are automatically rejected
  for (String primeMinister in ministers) {
    print('$primeMinister is a Prime Minister.');
  }
}

void collectionControlFlow() {
  final addMore = true;
  final randomNumbers = [
    34,
    232,
    54,
    32,
    if (addMore) ...[
      123,
      258,
      512,
    ],
  ];
  final doubled = [
    for (int number in randomNumbers) number * 2,
  ];
  print(doubled);
}
