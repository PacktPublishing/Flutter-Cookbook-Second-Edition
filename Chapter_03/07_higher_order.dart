List<Map> data = [
  {'first': 'Nada', 'last': 'Mueller', 'age': 10},
  {'first': 'Kurt', 'last': 'Gibbons', 'age': 9},
  {'first': 'Natalya', 'last': 'Compton', 'age': 15},
  {'first': 'Kaycee', 'last': 'Grant', 'age': 20},
  {'first': 'Kody', 'last': 'Ali', 'age': 17},
  {'first': 'Rhodri', 'last': 'Marshall', 'age': 30},
  {'first': 'Kali', 'last': 'Fleming', 'age': 9},
  {'first': 'Steve', 'last': 'Goulding', 'age': 32},
  {'first': 'Ivie', 'last': 'Haworth', 'age': 14},
  {'first': 'Anisha', 'last': 'Bourne', 'age': 40},
  {'first': 'Dominique', 'last': 'Madden', 'age': 31},
  {'first': 'Kornelia', 'last': 'Bass', 'age': 20},
  {'first': 'Saad', 'last': 'Feeney', 'age': 2},
  {'first': 'Eric', 'last': 'Lindsey', 'age': 51},
  {'first': 'Anushka', 'last': 'Harding', 'age': 23},
  {'first': 'Samiya', 'last': 'Allen', 'age': 18},
  {'first': 'Rabia', 'last': 'Merrill', 'age': 6},
  {'first': 'Safwan', 'last': 'Schaefer', 'age': 41},
  {'first': 'Celeste', 'last': 'Aldred', 'age': 34},
  {'first': 'Taio', 'last': 'Mathews', 'age': 17},
];

void main() {
  higherOrderFunctions();
}

void higherOrderFunctions() {
  final names = mapping();
  names.forEach(print);
  sorting();
  filtering();
  reducing();
  flattening();
}

class Name {
  final String first;
  final String last;
  Name(this.first, this.last);
  @override
  String toString() {
    return '$first $last';
  }
}

List<Name> mapping() {
// Transform the data from raw maps to a strongly typed model
  final names = data.map<Name>((Map rawName) {
    final first = rawName['first'];
    final last = rawName['last'];
    return Name(first, last);
  }).toList(); //don't forget the toList() method!
  return names;
}

void sorting() {
  final names = mapping();
// Sort the list by last name
  names.sort((a, b) => a.last.compareTo(b.last));
  print('');
  print('Alphabetical List of Names');
  names.forEach(print);
}

void filtering() {
  final names = mapping();
  final onlyMs = names.where((name) => name.last.startsWith('M'));
  print('');
  print('Filters name list by M');
  onlyMs.forEach(print);
}

void reducing() {
  // Merge an element of the data together
  final allAges = data.map<int>((person) => person['age']);
  final total = allAges.reduce((total, age) => total + age);
  final average = total / allAges.length;
  print('The average age is $average');
}

void flattening() {
  final matrix = [
    [1, 0, 0],
    [0, 0, -1],
    [0, 1, 0],
  ];
  final linear = matrix.expand<int>((row) => row);
  print(linear);
}
