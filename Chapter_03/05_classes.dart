void main() {
  classPlayground();
}

void classPlayground() {
  final name = OfficialName('Mr', 'Clark', 'Kent');
  final message = name.toString();
  print(message);
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

class OfficialName extends Name {
// Private properties begin with an underscore
  final String _title;
// You can add colons after constructor
// to parse data or delegate to super
  OfficialName(this._title, String first, String last) : super(first, last);
  @override
  String toString() {
    return '$_title. ${super.toString()}';
  }
}
