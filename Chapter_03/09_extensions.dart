void main() {
  testExtension();
}

extension StringExtensions on String {
  bool toBool() {
    return isNotEmpty;
  }
}

void testExtension() {
  String emptyString = "";
  String nonEmptyString = "Hello Extensions!";
  print(emptyString.toBool()); //--> false
  print(nonEmptyString.toBool()); //--> true
}
