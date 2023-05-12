void main() {
  consumeClosure();
}

typedef NumberGetter = int Function();

void callbackExample(void Function(String value) callback) {
  callback('Hello Callback');
}

void printSomething(String value) {
  print(value);
}

int powerOfTwo(NumberGetter getter) {
  return getter() * getter();
}

void consumeClosure() {
  int getFour() => 4;
  final squared = powerOfTwo(getFour);
  print(squared);
  callbackExample(printSomething);
}
