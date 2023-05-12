void main() {
  cascadePlayground();
}

class UrlBuilder {
  String scheme = '';
  String host = '';
  List<String> routes = [];
  @override
  String toString() {
    final paths = [host, if (routes != []) ...routes];
    final path = paths.join('/');
    return '$scheme://$path';
  }
}

void cascadePlayground() {
  final url = UrlBuilder()
    ..scheme = 'https'
    ..host = 'dart.dev'
    ..routes = [
      'guides',
      'language',
      'language-tour#cascade-notation',
    ];
  print(url);
  final numbers = [42, 88, 53, 232, 55]
    ..insert(0, 8)
    ..sort((a, b) => a.compareTo(b));

  print('The largest number in the list is ${numbers.last}');
}
